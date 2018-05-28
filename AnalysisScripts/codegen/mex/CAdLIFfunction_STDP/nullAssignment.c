/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * nullAssignment.c
 *
 * Code generation for function 'nullAssignment'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "nullAssignment.h"
#include "CAdLIFfunction_STDP_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "CAdLIFfunction_STDP_data.h"

/* Variable Definitions */
static emlrtRSInfo sc_emlrtRSI = { 21, /* lineNo */
  "nullAssignment",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pathName */
};

static emlrtRSInfo tc_emlrtRSI = { 25, /* lineNo */
  "nullAssignment",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pathName */
};

static emlrtRSInfo uc_emlrtRSI = { 274,/* lineNo */
  "nullAssignment",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pathName */
};

static emlrtRSInfo vc_emlrtRSI = { 282,/* lineNo */
  "nullAssignment",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pathName */
};

static emlrtRSInfo wc_emlrtRSI = { 284,/* lineNo */
  "nullAssignment",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pathName */
};

static emlrtRSInfo xc_emlrtRSI = { 287,/* lineNo */
  "nullAssignment",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pathName */
};

static emlrtRSInfo yc_emlrtRSI = { 258,/* lineNo */
  "nullAssignment",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pathName */
};

static emlrtRSInfo ad_emlrtRSI = { 131,/* lineNo */
  "nullAssignment",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pathName */
};

static emlrtRTEInfo ph_emlrtRTEI = { 282,/* lineNo */
  9,                                   /* colNo */
  "nullAssignment",                    /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pName */
};

static emlrtRTEInfo qh_emlrtRTEI = { 297,/* lineNo */
  5,                                   /* colNo */
  "nullAssignment",                    /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pName */
};

static emlrtRTEInfo rh_emlrtRTEI = { 25,/* lineNo */
  13,                                  /* colNo */
  "nullAssignment",                    /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pName */
};

static emlrtRTEInfo sh_emlrtRTEI = { 280,/* lineNo */
  9,                                   /* colNo */
  "nullAssignment",                    /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pName */
};

static emlrtRTEInfo hi_emlrtRTEI = { 296,/* lineNo */
  1,                                   /* colNo */
  "nullAssignment",                    /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pName */
};

static emlrtRTEInfo ii_emlrtRTEI = { 80,/* lineNo */
  27,                                  /* colNo */
  "nullAssignment",                    /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pName */
};

/* Function Definitions */
void b_nullAssignment(const emlrtStack *sp, emxArray_real32_T *x, const
                      emxArray_boolean_T *idx)
{
  int32_T k;
  int32_T nrowx;
  int32_T nrows;
  boolean_T overflow;
  int32_T i;
  int32_T j;
  emxArray_real32_T *b_x;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &sc_emlrtRSI;
  k = idx->size[0];
  while ((k >= 1) && (!idx->data[k - 1])) {
    k--;
  }

  if (!(k <= x->size[0])) {
    emlrtErrorWithMessageIdR2018a(&st, &ii_emlrtRTEI,
      "MATLAB:subsdeldimmismatch", "MATLAB:subsdeldimmismatch", 0);
  }

  st.site = &tc_emlrtRSI;
  nrowx = x->size[0];
  b_st.site = &wc_emlrtRSI;
  nrows = 0;
  c_st.site = &ad_emlrtRSI;
  overflow = ((!(1 > idx->size[0])) && (idx->size[0] > 2147483646));
  if (overflow) {
    d_st.site = &kb_emlrtRSI;
    check_forloop_overflow_error(&d_st);
  }

  for (k = 1; k <= idx->size[0]; k++) {
    nrows += idx->data[k - 1];
  }

  nrows = x->size[0] - nrows;
  i = 0;
  b_st.site = &xc_emlrtRSI;
  overflow = ((!(1 > x->size[0])) && (x->size[0] > 2147483646));
  if (overflow) {
    c_st.site = &kb_emlrtRSI;
    check_forloop_overflow_error(&c_st);
  }

  for (k = 1; k <= nrowx; k++) {
    if ((k > idx->size[0]) || (!idx->data[k - 1])) {
      for (j = 0; j < 2; j++) {
        x->data[i + x->size[0] * j] = x->data[(k + x->size[0] * j) - 1];
      }

      i++;
    }
  }

  if (!(nrows <= nrowx)) {
    emlrtErrorWithMessageIdR2018a(&st, &hi_emlrtRTEI,
      "Coder:builtins:AssertionFailed", "Coder:builtins:AssertionFailed", 0);
  }

  if (1 > nrows) {
    nrows = 0;
  }

  emxInit_real32_T(&st, &b_x, 2, &qh_emlrtRTEI, true);
  i = b_x->size[0] * b_x->size[1];
  b_x->size[0] = nrows;
  b_x->size[1] = 2;
  emxEnsureCapacity_real32_T(&st, b_x, i, &qh_emlrtRTEI);
  for (i = 0; i < 2; i++) {
    for (j = 0; j < nrows; j++) {
      b_x->data[j + b_x->size[0] * i] = x->data[j + x->size[0] * i];
    }
  }

  i = x->size[0] * x->size[1];
  x->size[0] = b_x->size[0];
  x->size[1] = 2;
  emxEnsureCapacity_real32_T(&st, x, i, &rh_emlrtRTEI);
  for (i = 0; i < 2; i++) {
    nrows = b_x->size[0];
    for (j = 0; j < nrows; j++) {
      x->data[j + x->size[0] * i] = b_x->data[j + b_x->size[0] * i];
    }
  }

  emxFree_real32_T(&st, &b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void nullAssignment(const emlrtStack *sp, emxArray_real32_T *x, const
                    emxArray_int32_T *idx)
{
  boolean_T overflow;
  int32_T k;
  boolean_T exitg1;
  int32_T nrowx;
  emxArray_boolean_T *b;
  int32_T nrows;
  int32_T loop_ub;
  int32_T i;
  emxArray_real32_T *b_x;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &sc_emlrtRSI;
  overflow = true;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k <= idx->size[1] - 1)) {
    if ((idx->data[k] < 1) || (idx->data[k] > x->size[0])) {
      overflow = false;
      exitg1 = true;
    } else {
      k++;
    }
  }

  if (!overflow) {
    emlrtErrorWithMessageIdR2018a(&st, &ii_emlrtRTEI,
      "MATLAB:subsdeldimmismatch", "MATLAB:subsdeldimmismatch", 0);
  }

  st.site = &tc_emlrtRSI;
  nrowx = x->size[0];
  if (idx->size[1] == 1) {
    nrows = x->size[0] - 1;
    for (loop_ub = 0; loop_ub < 2; loop_ub++) {
      b_st.site = &uc_emlrtRSI;
      overflow = ((!(idx->data[0] > nrowx - 1)) && (nrowx - 1 > 2147483646));
      if (overflow) {
        c_st.site = &kb_emlrtRSI;
        check_forloop_overflow_error(&c_st);
      }

      for (i = idx->data[0]; i < nrowx; i++) {
        x->data[(i + x->size[0] * loop_ub) - 1] = x->data[i + x->size[0] *
          loop_ub];
      }
    }
  } else {
    emxInit_boolean_T(&st, &b, 2, &sh_emlrtRTEI, true);
    b_st.site = &vc_emlrtRSI;
    i = b->size[0] * b->size[1];
    b->size[0] = 1;
    b->size[1] = x->size[0];
    emxEnsureCapacity_boolean_T(&b_st, b, i, &ph_emlrtRTEI);
    loop_ub = x->size[0];
    for (i = 0; i < loop_ub; i++) {
      b->data[i] = false;
    }

    c_st.site = &yc_emlrtRSI;
    overflow = ((!(1 > idx->size[1])) && (idx->size[1] > 2147483646));
    if (overflow) {
      d_st.site = &kb_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (k = 1; k <= idx->size[1]; k++) {
      b->data[idx->data[k - 1] - 1] = true;
    }

    b_st.site = &wc_emlrtRSI;
    nrows = 0;
    c_st.site = &ad_emlrtRSI;
    overflow = ((!(1 > b->size[1])) && (b->size[1] > 2147483646));
    if (overflow) {
      d_st.site = &kb_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (k = 1; k <= b->size[1]; k++) {
      nrows += b->data[k - 1];
    }

    nrows = x->size[0] - nrows;
    i = 0;
    b_st.site = &xc_emlrtRSI;
    overflow = ((!(1 > x->size[0])) && (x->size[0] > 2147483646));
    if (overflow) {
      c_st.site = &kb_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (k = 1; k <= nrowx; k++) {
      if ((k > b->size[1]) || (!b->data[k - 1])) {
        for (loop_ub = 0; loop_ub < 2; loop_ub++) {
          x->data[i + x->size[0] * loop_ub] = x->data[(k + x->size[0] * loop_ub)
            - 1];
        }

        i++;
      }
    }

    emxFree_boolean_T(&st, &b);
  }

  if (!(nrows <= nrowx)) {
    emlrtErrorWithMessageIdR2018a(&st, &hi_emlrtRTEI,
      "Coder:builtins:AssertionFailed", "Coder:builtins:AssertionFailed", 0);
  }

  if (1 > nrows) {
    loop_ub = 0;
  } else {
    loop_ub = nrows;
  }

  emxInit_real32_T(&st, &b_x, 2, &qh_emlrtRTEI, true);
  i = b_x->size[0] * b_x->size[1];
  b_x->size[0] = loop_ub;
  b_x->size[1] = 2;
  emxEnsureCapacity_real32_T(&st, b_x, i, &qh_emlrtRTEI);
  for (i = 0; i < 2; i++) {
    for (nrows = 0; nrows < loop_ub; nrows++) {
      b_x->data[nrows + b_x->size[0] * i] = x->data[nrows + x->size[0] * i];
    }
  }

  i = x->size[0] * x->size[1];
  x->size[0] = b_x->size[0];
  x->size[1] = 2;
  emxEnsureCapacity_real32_T(&st, x, i, &rh_emlrtRTEI);
  for (i = 0; i < 2; i++) {
    loop_ub = b_x->size[0];
    for (nrows = 0; nrows < loop_ub; nrows++) {
      x->data[nrows + x->size[0] * i] = b_x->data[nrows + b_x->size[0] * i];
    }
  }

  emxFree_real32_T(&st, &b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (nullAssignment.c) */
