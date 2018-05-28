/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * randi.c
 *
 * Code generation for function 'randi'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "randi.h"

/* Function Definitions */
real_T randi(real_T lowhigh)
{
  real_T r;
  emlrtRandu(&r, 1);
  return 1.0 + muDoubleScalarFloor(r * lowhigh);
}

/* End of code generation (randi.c) */
