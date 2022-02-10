//---------------------------------------------------------------------------// 
// Copyright (c) 2013 Kyle Lutz <kyle.r.lutz@gmail.com> 
// 
// Distributed under the Boost Software License, Version 1.0 
// See accompanying file LICENSE_1_0.txt or copy at 
// http://www.boost.org/LICENSE_1_0.txt 
// 
// See http://boostorg.github.com/compute for more information. 
//---------------------------------------------------------------------------// 
 
#ifndef BOOST_COMPUTE_ALGORITHM_INCLUSIVE_SCAN_HPP 
#define BOOST_COMPUTE_ALGORITHM_INCLUSIVE_SCAN_HPP 
 
#include <boost/compute/functional.hpp> 
#include <boost/compute/system.hpp> 
#include <boost/compute/command_queue.hpp> 
#include <boost/compute/algorithm/detail/scan.hpp> 
 
namespace boost { 
namespace compute { 
 
/// Performs an inclusive scan of the elements in the range [\p first, \p last) 
/// and stores the results in the range beginning at \p result. 
/// 
/// Each element in the output is assigned to the sum of the current value in 
/// the input with the sum of every previous value in the input. 
/// 
/// \param first first element in the range to scan 
/// \param last last element in the range to scan 
/// \param result first element in the result range 
/// \param binary_op associative binary operator 
/// \param queue command queue to perform the operation 
/// 
/// \return \c OutputIterator to the end of the result range 
/// 
/// The default operation is to add the elements up. 
/// 
/// \snippet test/test_scan.cpp inclusive_scan_int 
/// 
/// But different associative operation can be specified as \p binary_op 
/// instead (e.g., multiplication, maximum, minimum). 
/// 
/// \snippet test/test_scan.cpp inclusive_scan_int_multiplies 
/// 
/// Space complexity on GPUs: \Omega(n)<br> 
/// Space complexity on GPUs when \p first == \p result: \Omega(2n)<br> 
/// Space complexity on CPUs: \Omega(1) 
/// 
/// \see exclusive_scan() 
template<class InputIterator, class OutputIterator, class BinaryOperator> 
inline OutputIterator 
inclusive_scan(InputIterator first, 
               InputIterator last, 
               OutputIterator result, 
               BinaryOperator binary_op, 
               command_queue &queue = system::default_queue()) 
{ 
    typedef typename 
        std::iterator_traits<OutputIterator>::value_type output_type; 
 
    return detail::scan(first, last, result, false, 
                        output_type(0), binary_op, 
                        queue); 
} 
 
/// \overload 
template<class InputIterator, class OutputIterator> 
inline OutputIterator 
inclusive_scan(InputIterator first, 
               InputIterator last, 
               OutputIterator result, 
               command_queue &queue = system::default_queue()) 
{ 
    typedef typename 
        std::iterator_traits<OutputIterator>::value_type output_type; 
 
    return detail::scan(first, last, result, false, 
                        output_type(0), boost::compute::plus<output_type>(), 
                        queue); 
} 
 
} // end compute namespace 
} // end boost namespace 
 
#endif // BOOST_COMPUTE_ALGORITHM_INCLUSIVE_SCAN_HPP 
