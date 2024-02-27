#pragma once

#include "fluent_settings_helpers.h"

namespace NYdb {

enum class ES3Scheme {
    HTTP = 1 /* "http" */,
    HTTPS = 2 /* "https" */,
};

template <typename TDerived>
struct TS3Settings {
    using TSelf = TDerived;

    FLUENT_SETTING(std::string, Endpoint);
    FLUENT_SETTING_DEFAULT(ES3Scheme, Scheme, ES3Scheme::HTTPS);
    FLUENT_SETTING(std::string, Bucket);
    FLUENT_SETTING(std::string, AccessKey);
    FLUENT_SETTING(std::string, SecretKey);
};

} // namespace NYdb
