/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * any.c
 *
 * Code generation for function 'any'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "any.h"
#include "eml_int_forloop_overflow_check.h"
#include "CAdLIFfunction_STDP_data.h"

/* Variable Definitions */
static emlrtRSInfo gc_emlrtRSI = { 12, /* lineNo */
  "any",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\ops\\any.m"/* pathName */
};

static emlrtRSInfo hc_emlrtRSI = { 146,/* lineNo */
  "allOrAny",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\allOrAny.m"/* pathName */
};

static emlrtRTEInfo gi_emlrtRTEI = { 46,/* lineNo */
  19,                                  /* colNo */
  "allOrAny",                          /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\allOrAny.m"/* pName */
};

/* Function Definitions */
boolean_T any(const emlrtStack *sp, const emxArray_boolean_T *x)
{
  boolean_T y;
  boolean_T overflow;
  int32_T ix;
  boolean_T exitg1;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &gc_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  if ((x->size[0] == 1) || (x->size[0] != 1)) {
  } else {
    emlrtErrorWithMessageIdR2018a(&st, &gi_emlrtRTEI,
      "Coder:toolbox:eml_all_or_any_autoDimIncompatibility",
      "Coder:toolbox:eml_all_or_any_autoDimIncompatibility", 0);
  }

  y = false;
  b_st.site = &hc_emlrtRSI;
  overflow = ((!(1 > x->size[0])) && (x->size[0] > 2147483646));
  if (overflow) {
    c_st.site = &kb_emlrtRSI;
    check_forloop_overflow_error(&c_st);
  }

  ix = 1;
  exitg1 = false;
  while ((!exitg1) && (ix <= x->size[0])) {
    overflow = !x->data[ix - 1];
    if (!overflow) {
      y = true;
      exitg1 = true;
    } else {
      ix++;
    }
  }

  return y;
}

/* End of code generation (any.c) */
