#pragma once

#include <src/client/federated_topic/impl/federated_topic_impl.h>

#include <src/client/persqueue_core/impl/callback_context.h>
#include <src/client/persqueue_core/impl/read_session.h>

#include <src/client/topic/impl/read_session.h>

namespace NYdb::NFederatedTopic {

class TFederatedReadSessionImpl : public NPersQueue::TEnableSelfContext<TFederatedReadSessionImpl> {
    friend class TFederatedTopicClient::TImpl;
    friend class TFederatedReadSession;

private:
    struct TSubSession {
        TSubSession(std::shared_ptr<NTopic::IReadSession> session = {}, std::shared_ptr<TDbInfo> dbInfo = {})
            : Session(std::move(session))
            , DbInfo(std::move(dbInfo))
            {}

        std::shared_ptr<NTopic::IReadSession> Session;
        std::shared_ptr<TDbInfo> DbInfo;
    };

public:
    TFederatedReadSessionImpl(const TFederatedReadSessionSettings& settings,
                              std::shared_ptr<TGRpcConnectionsImpl> connections,
                              const TFederatedTopicClientSettings& clientSetttings,
                              std::shared_ptr<TFederatedDbObserver> observer);

    ~TFederatedReadSessionImpl() = default;

    NThreading::TFuture<void> WaitEvent();
    std::vector<TReadSessionEvent::TEvent> GetEvents(bool block, std::optional<size_t> maxEventsCount, size_t maxByteSize);

    bool Close(TDuration timeout);

    inline std::string GetSessionId() const {
        return SessionId;
    }

    inline NTopic::TReaderCounters::TPtr GetCounters() const {
        return Settings.Counters_; // Always not nullptr.
    }

private:
    // TODO logging
    TStringBuilder GetLogPrefix() const;

    void Start();
    bool ValidateSettings();
    void OpenSubSessionsImpl();

    void OnFederatedStateUpdateImpl();

    void CloseImpl();

private:
    TFederatedReadSessionSettings Settings;

    // For subsessions creation
    std::shared_ptr<TGRpcConnectionsImpl> Connections;
    const NTopic::TTopicClientSettings SubClientSetttings;

    std::shared_ptr<TFederatedDbObserver> Observer;
    NThreading::TFuture<void> AsyncInit;
    std::shared_ptr<TFederatedDbState> FederationState;

    // TODO
    // TLog Log;

    const std::string SessionId;
    const TInstant StartSessionTime = TInstant::Now();

    TAdaptiveLock Lock;

    std::vector<TSubSession> SubSessions;
    size_t SubsessionIndex = 0;

    // Exiting.
    bool Closing = false;
};


class TFederatedReadSession : public IFederatedReadSession,
                              public NPersQueue::TContextOwner<TFederatedReadSessionImpl> {
    friend class TFederatedTopicClient::TImpl;

public:
    TFederatedReadSession(const TFederatedReadSessionSettings& settings,
                          std::shared_ptr<TGRpcConnectionsImpl> connections,
                          const TFederatedTopicClientSettings& clientSettings,
                          std::shared_ptr<TFederatedDbObserver> observer)
        : TContextOwner(settings, std::move(connections), clientSettings, std::move(observer)) {
    }

    ~TFederatedReadSession() {
        TryGetImpl()->Close(TDuration::Zero());
    }

    NThreading::TFuture<void> WaitEvent() override  {
        return TryGetImpl()->WaitEvent();
    }

    std::vector<TReadSessionEvent::TEvent> GetEvents(bool block, std::optional<size_t> maxEventsCount, size_t maxByteSize) override {
        return TryGetImpl()->GetEvents(block, maxEventsCount, maxByteSize);
    }

    std::optional<TReadSessionEvent::TEvent> GetEvent(bool block, size_t maxByteSize) override {
    auto events = GetEvents(block, 1, maxByteSize);
        return events.empty() ? std::nullopt : std::optional<TReadSessionEvent::TEvent>{std::move(events.front())};
    }

    bool Close(TDuration timeout) override {
        return TryGetImpl()->Close(timeout);
    }

    inline std::string GetSessionId() const override {
        return TryGetImpl()->GetSessionId();
    }

    inline NTopic::TReaderCounters::TPtr GetCounters() const override {
        return TryGetImpl()->GetCounters();
    }

private:
    void Start() {
        return TryGetImpl()->Start();
    }
};

} // namespace NYdb::NFederatedTopic
