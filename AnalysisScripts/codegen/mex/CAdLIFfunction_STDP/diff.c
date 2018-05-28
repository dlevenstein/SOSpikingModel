/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * diff.c
 *
 * Code generation for function 'diff'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "diff.h"

/* Function Definitions */
real_T diff(const real_T x[2])
{
  return x[1] - x[0];
}

/* End of code generation (diff.c) */
