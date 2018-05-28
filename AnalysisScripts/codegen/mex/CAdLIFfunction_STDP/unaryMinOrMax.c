/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * unaryMinOrMax.c
 *
 * Code generation for function 'unaryMinOrMax'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "unaryMinOrMax.h"
#include "eml_int_forloop_overflow_check.h"
#include "CAdLIFfunction_STDP_data.h"

/* Variable Definitions */
static emlrtRSInfo yb_emlrtRSI = { 894,/* lineNo */
  "unaryMinOrMax",                     /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\unaryMinOrMax.m"/* pathName */
};

/* Function Definitions */
int32_T findFirst(const emlrtStack *sp, const emxArray_real_T *x)
{
  int32_T idx;
  boolean_T overflow;
  int32_T k;
  boolean_T exitg1;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  if (!muDoubleScalarIsNaN(x->data[0])) {
    idx = 1;
  } else {
    idx = 0;
    st.site = &yb_emlrtRSI;
    overflow = ((!(2 > x->size[0])) && (x->size[0] > 2147483646));
    if (overflow) {
      b_st.site = &kb_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    k = 2;
    exitg1 = false;
    while ((!exitg1) && (k <= x->size[0])) {
      if (!muDoubleScalarIsNaN(x->data[k - 1])) {
        idx = k;
        exitg1 = true;
      } else {
        k++;
      }
    }
  }

  return idx;
}

/* End of code generation (unaryMinOrMax.c) */
