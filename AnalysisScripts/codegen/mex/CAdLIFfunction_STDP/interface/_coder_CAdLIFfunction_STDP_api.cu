/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_CAdLIFfunction_STDP_api.cu
 *
 * Code generation for function '_coder_CAdLIFfunction_STDP_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "_coder_CAdLIFfunction_STDP_api.h"
#include "CAdLIFfunction_STDP_emxutil.h"
#include "CAdLIFfunction_STDP_data.h"

/* Function Declarations */
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct0_T *y);
static real_T c_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[2]);
static struct1_T e_emlrt_marshallIn(const mxArray *TimeParams, const char_T
  *identifier);
static void emlrt_marshallIn(const mxArray *PopParams, const char_T *identifier,
  struct0_T *y);
static const mxArray *emlrt_marshallOut(const struct2_T *u);
static struct1_T f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static real_T g_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static void h_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[2]);

/* Function Definitions */
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  static const char * fieldNames[31] = { "I_e", "sigma", "theta", "EPopNum",
    "IPopNum", "E_L", "g_L", "C", "V_th", "V_reset", "t_ref", "E_e", "E_i",
    "tau_s", "E_w", "b_w", "b", "delta_T", "w_r", "gwnorm", "Wee", "Wii", "Wie",
    "Wei", "Kee", "Kii", "Kie", "Kei", "LearningRate", "TargetRate", "tauSTDP" };

  static const int32_T dims = 0;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(emlrtRootTLSGlobal, parentId, u, 31, fieldNames, 0U,
    &dims);
  thisId.fIdentifier = "I_e";
  y->I_e = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 0, "I_e")), &thisId);
  thisId.fIdentifier = "sigma";
  y->sigma = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 1, "sigma")), &thisId);
  thisId.fIdentifier = "theta";
  y->theta = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 2, "theta")), &thisId);
  thisId.fIdentifier = "EPopNum";
  y->EPopNum = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 3, "EPopNum")), &thisId);
  thisId.fIdentifier = "IPopNum";
  y->IPopNum = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 4, "IPopNum")), &thisId);
  thisId.fIdentifier = "E_L";
  d_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal, u, 0, 5,
    "E_L")), &thisId, y->E_L);
  thisId.fIdentifier = "g_L";
  d_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal, u, 0, 6,
    "g_L")), &thisId, y->g_L);
  thisId.fIdentifier = "C";
  d_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal, u, 0, 7,
    "C")), &thisId, y->C);
  thisId.fIdentifier = "V_th";
  d_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal, u, 0, 8,
    "V_th")), &thisId, y->V_th);
  thisId.fIdentifier = "V_reset";
  d_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal, u, 0, 9,
    "V_reset")), &thisId, y->V_reset);
  thisId.fIdentifier = "t_ref";
  y->t_ref = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 10, "t_ref")), &thisId);
  thisId.fIdentifier = "E_e";
  y->E_e = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 11, "E_e")), &thisId);
  thisId.fIdentifier = "E_i";
  y->E_i = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 12, "E_i")), &thisId);
  thisId.fIdentifier = "tau_s";
  d_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal, u, 0, 13,
    "tau_s")), &thisId, y->tau_s);
  thisId.fIdentifier = "E_w";
  y->E_w = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 14, "E_w")), &thisId);
  thisId.fIdentifier = "b_w";
  y->b_w = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 15, "b_w")), &thisId);
  thisId.fIdentifier = "b";
  y->b = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal, u,
    0, 16, "b")), &thisId);
  thisId.fIdentifier = "delta_T";
  y->delta_T = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 17, "delta_T")), &thisId);
  thisId.fIdentifier = "w_r";
  y->w_r = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 18, "w_r")), &thisId);
  thisId.fIdentifier = "gwnorm";
  y->gwnorm = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 19, "gwnorm")), &thisId);
  thisId.fIdentifier = "Wee";
  y->Wee = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 20, "Wee")), &thisId);
  thisId.fIdentifier = "Wii";
  y->Wii = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 21, "Wii")), &thisId);
  thisId.fIdentifier = "Wie";
  y->Wie = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 22, "Wie")), &thisId);
  thisId.fIdentifier = "Wei";
  y->Wei = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 23, "Wei")), &thisId);
  thisId.fIdentifier = "Kee";
  y->Kee = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 24, "Kee")), &thisId);
  thisId.fIdentifier = "Kii";
  y->Kii = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 25, "Kii")), &thisId);
  thisId.fIdentifier = "Kie";
  y->Kie = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 26, "Kie")), &thisId);
  thisId.fIdentifier = "Kei";
  y->Kei = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal,
    u, 0, 27, "Kei")), &thisId);
  thisId.fIdentifier = "LearningRate";
  y->LearningRate = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 28, "LearningRate")), &thisId);
  thisId.fIdentifier = "TargetRate";
  y->TargetRate = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 29, "TargetRate")), &thisId);
  thisId.fIdentifier = "tauSTDP";
  y->tauSTDP = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 30, "tauSTDP")), &thisId);
  emlrtDestroyArray(&u);
}

static real_T c_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = g_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[2])
{
  h_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static struct1_T e_emlrt_marshallIn(const mxArray *TimeParams, const char_T
  *identifier)
{
  struct1_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(emlrtAlias(TimeParams), &thisId);
  emlrtDestroyArray(&TimeParams);
  return y;
}

static void emlrt_marshallIn(const mxArray *PopParams, const char_T *identifier,
  struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(PopParams), &thisId, y);
  emlrtDestroyArray(&PopParams);
}

static const mxArray *emlrt_marshallOut(const struct2_T *u)
{
  const mxArray *y;
  emxArray_real_T *b_u;
  static const char * sv0[14] = { "t", "V", "g_w", "g_e", "g_i", "s", "w", "a_w",
    "Input", "t_weight", "WeightMat", "spikes", "EcellIDX", "IcellIDX" };

  int32_T i1;
  const mxArray *b_y;
  const mxArray *m1;
  real_T *pData;
  int32_T loopUpperBound;
  int32_T i;
  emxArray_real_T *c_u;
  emxArray_real_T *d_u;
  int32_T b_loopUpperBound;
  int32_T b_i;
  emxArray_real_T *e_u;
  emxArray_real_T *f_u;
  emxArray_real_T *g_u;
  emxArray_real_T *h_u;
  emxArray_real_T *i_u;
  emxArray_real_T *j_u;
  emxArray_real_T *k_u;
  emxArray_real_T *l_u;
  emxArray_real32_T *m_u;
  int32_T c_loopUpperBound;
  int32_T c_i;
  real32_T *b_pData;
  emxArray_real_T *n_u;
  emxArray_real_T *o_u;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_u, 2, true);
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 14, sv0));
  i1 = b_u->size[0] * b_u->size[1];
  b_u->size[0] = 1;
  b_u->size[1] = u->t->size[1];
  emxEnsureCapacity_real_T(b_u, i1);
  for (i1 = 0; i1 < u->t->size[0] * u->t->size[1]; i1++) {
    b_u->data[i1] = u->t->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])b_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->t->size[1];
  emxFree_real_T(&b_u);
  for (i = 0; i < loopUpperBound; i++) {
    pData[i1] = u->t->data[u->t->size[0] * i];
    i1++;
  }

  emxInit_real_T(&c_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "t", b_y, 0);
  i1 = c_u->size[0] * c_u->size[1];
  c_u->size[0] = u->V->size[0];
  c_u->size[1] = u->V->size[1];
  emxEnsureCapacity_real_T(c_u, i1);
  for (i1 = 0; i1 < u->V->size[0] * u->V->size[1]; i1++) {
    c_u->data[i1] = u->V->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])c_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->V->size[1];
  emxFree_real_T(&c_u);
  for (i = 0; i < loopUpperBound; i++) {
    b_loopUpperBound = u->V->size[0];
    for (b_i = 0; b_i < b_loopUpperBound; b_i++) {
      pData[i1] = u->V->data[b_i + u->V->size[0] * i];
      i1++;
    }
  }

  emxInit_real_T(&d_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "V", b_y, 1);
  i1 = d_u->size[0] * d_u->size[1];
  d_u->size[0] = u->g_w->size[0];
  d_u->size[1] = u->g_w->size[1];
  emxEnsureCapacity_real_T(d_u, i1);
  for (i1 = 0; i1 < u->g_w->size[0] * u->g_w->size[1]; i1++) {
    d_u->data[i1] = u->g_w->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])d_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->g_w->size[1];
  emxFree_real_T(&d_u);
  for (i = 0; i < loopUpperBound; i++) {
    b_loopUpperBound = u->g_w->size[0];
    for (b_i = 0; b_i < b_loopUpperBound; b_i++) {
      pData[i1] = u->g_w->data[b_i + u->g_w->size[0] * i];
      i1++;
    }
  }

  emxInit_real_T(&e_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "g_w", b_y, 2);
  i1 = e_u->size[0] * e_u->size[1];
  e_u->size[0] = u->g_e->size[0];
  e_u->size[1] = u->g_e->size[1];
  emxEnsureCapacity_real_T(e_u, i1);
  for (i1 = 0; i1 < u->g_e->size[0] * u->g_e->size[1]; i1++) {
    e_u->data[i1] = u->g_e->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])e_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->g_e->size[1];
  emxFree_real_T(&e_u);
  for (i = 0; i < loopUpperBound; i++) {
    b_loopUpperBound = u->g_e->size[0];
    for (b_i = 0; b_i < b_loopUpperBound; b_i++) {
      pData[i1] = u->g_e->data[b_i + u->g_e->size[0] * i];
      i1++;
    }
  }

  emxInit_real_T(&f_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "g_e", b_y, 3);
  i1 = f_u->size[0] * f_u->size[1];
  f_u->size[0] = u->g_i->size[0];
  f_u->size[1] = u->g_i->size[1];
  emxEnsureCapacity_real_T(f_u, i1);
  for (i1 = 0; i1 < u->g_i->size[0] * u->g_i->size[1]; i1++) {
    f_u->data[i1] = u->g_i->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])f_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->g_i->size[1];
  emxFree_real_T(&f_u);
  for (i = 0; i < loopUpperBound; i++) {
    b_loopUpperBound = u->g_i->size[0];
    for (b_i = 0; b_i < b_loopUpperBound; b_i++) {
      pData[i1] = u->g_i->data[b_i + u->g_i->size[0] * i];
      i1++;
    }
  }

  emxInit_real_T(&g_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "g_i", b_y, 4);
  i1 = g_u->size[0] * g_u->size[1];
  g_u->size[0] = u->s->size[0];
  g_u->size[1] = u->s->size[1];
  emxEnsureCapacity_real_T(g_u, i1);
  for (i1 = 0; i1 < u->s->size[0] * u->s->size[1]; i1++) {
    g_u->data[i1] = u->s->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])g_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->s->size[1];
  emxFree_real_T(&g_u);
  for (i = 0; i < loopUpperBound; i++) {
    b_loopUpperBound = u->s->size[0];
    for (b_i = 0; b_i < b_loopUpperBound; b_i++) {
      pData[i1] = u->s->data[b_i + u->s->size[0] * i];
      i1++;
    }
  }

  emxInit_real_T(&h_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "s", b_y, 5);
  i1 = h_u->size[0] * h_u->size[1];
  h_u->size[0] = u->w->size[0];
  h_u->size[1] = u->w->size[1];
  emxEnsureCapacity_real_T(h_u, i1);
  for (i1 = 0; i1 < u->w->size[0] * u->w->size[1]; i1++) {
    h_u->data[i1] = u->w->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])h_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->w->size[1];
  emxFree_real_T(&h_u);
  for (i = 0; i < loopUpperBound; i++) {
    b_loopUpperBound = u->w->size[0];
    for (b_i = 0; b_i < b_loopUpperBound; b_i++) {
      pData[i1] = u->w->data[b_i + u->w->size[0] * i];
      i1++;
    }
  }

  emxInit_real_T(&i_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "w", b_y, 6);
  i1 = i_u->size[0] * i_u->size[1];
  i_u->size[0] = u->a_w->size[0];
  i_u->size[1] = u->a_w->size[1];
  emxEnsureCapacity_real_T(i_u, i1);
  for (i1 = 0; i1 < u->a_w->size[0] * u->a_w->size[1]; i1++) {
    i_u->data[i1] = u->a_w->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])i_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->a_w->size[1];
  emxFree_real_T(&i_u);
  for (i = 0; i < loopUpperBound; i++) {
    b_loopUpperBound = u->a_w->size[0];
    for (b_i = 0; b_i < b_loopUpperBound; b_i++) {
      pData[i1] = u->a_w->data[b_i + u->a_w->size[0] * i];
      i1++;
    }
  }

  emxInit_real_T(&j_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "a_w", b_y, 7);
  i1 = j_u->size[0] * j_u->size[1];
  j_u->size[0] = u->Input->size[0];
  j_u->size[1] = u->Input->size[1];
  emxEnsureCapacity_real_T(j_u, i1);
  for (i1 = 0; i1 < u->Input->size[0] * u->Input->size[1]; i1++) {
    j_u->data[i1] = u->Input->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])j_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->Input->size[1];
  emxFree_real_T(&j_u);
  for (i = 0; i < loopUpperBound; i++) {
    b_loopUpperBound = u->Input->size[0];
    for (b_i = 0; b_i < b_loopUpperBound; b_i++) {
      pData[i1] = u->Input->data[b_i + u->Input->size[0] * i];
      i1++;
    }
  }

  emxInit_real_T(&k_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "Input", b_y, 8);
  i1 = k_u->size[0] * k_u->size[1];
  k_u->size[0] = 1;
  k_u->size[1] = u->t_weight->size[1];
  emxEnsureCapacity_real_T(k_u, i1);
  for (i1 = 0; i1 < u->t_weight->size[0] * u->t_weight->size[1]; i1++) {
    k_u->data[i1] = u->t_weight->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])k_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->t_weight->size[1];
  emxFree_real_T(&k_u);
  for (i = 0; i < loopUpperBound; i++) {
    pData[i1] = u->t_weight->data[u->t_weight->size[0] * i];
    i1++;
  }

  emxInit_real_T2(&l_u, 3, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "t_weight", b_y, 9);
  i1 = l_u->size[0] * l_u->size[1] * l_u->size[2];
  l_u->size[0] = u->WeightMat->size[0];
  l_u->size[1] = u->WeightMat->size[1];
  l_u->size[2] = u->WeightMat->size[2];
  emxEnsureCapacity_real_T2(l_u, i1);
  for (i1 = 0; i1 < u->WeightMat->size[0] * u->WeightMat->size[1] * u->
       WeightMat->size[2]; i1++) {
    l_u->data[i1] = u->WeightMat->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(3, *(int32_T (*)[1])l_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->WeightMat->size[2];
  emxFree_real_T(&l_u);
  for (i = 0; i < loopUpperBound; i++) {
    b_loopUpperBound = u->WeightMat->size[1];
    for (b_i = 0; b_i < b_loopUpperBound; b_i++) {
      c_loopUpperBound = u->WeightMat->size[0];
      for (c_i = 0; c_i < c_loopUpperBound; c_i++) {
        pData[i1] = u->WeightMat->data[(c_i + u->WeightMat->size[0] * b_i) +
          u->WeightMat->size[0] * u->WeightMat->size[1] * i];
        i1++;
      }
    }
  }

  emxInit_real32_T(&m_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "WeightMat", b_y, 10);
  i1 = m_u->size[0] * m_u->size[1];
  m_u->size[0] = u->spikes->size[0];
  m_u->size[1] = 2;
  emxEnsureCapacity_real32_T(m_u, i1);
  for (i1 = 0; i1 < u->spikes->size[0] * u->spikes->size[1]; i1++) {
    m_u->data[i1] = u->spikes->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])m_u->size, mxSINGLE_CLASS,
    mxREAL);
  b_pData = (real32_T *)emlrtMxGetData(m1);
  i1 = 0;
  emxFree_real32_T(&m_u);
  for (i = 0; i < 2; i++) {
    loopUpperBound = u->spikes->size[0];
    for (b_i = 0; b_i < loopUpperBound; b_i++) {
      b_pData[i1] = u->spikes->data[b_i + u->spikes->size[0] * i];
      i1++;
    }
  }

  emxInit_real_T(&n_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "spikes", b_y, 11);
  i1 = n_u->size[0] * n_u->size[1];
  n_u->size[0] = 1;
  n_u->size[1] = u->EcellIDX->size[1];
  emxEnsureCapacity_real_T(n_u, i1);
  for (i1 = 0; i1 < u->EcellIDX->size[0] * u->EcellIDX->size[1]; i1++) {
    n_u->data[i1] = u->EcellIDX->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])n_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->EcellIDX->size[1];
  emxFree_real_T(&n_u);
  for (i = 0; i < loopUpperBound; i++) {
    pData[i1] = u->EcellIDX->data[u->EcellIDX->size[0] * i];
    i1++;
  }

  emxInit_real_T(&o_u, 2, true);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "EcellIDX", b_y, 12);
  i1 = o_u->size[0] * o_u->size[1];
  o_u->size[0] = 1;
  o_u->size[1] = u->IcellIDX->size[1];
  emxEnsureCapacity_real_T(o_u, i1);
  for (i1 = 0; i1 < u->IcellIDX->size[0] * u->IcellIDX->size[1]; i1++) {
    o_u->data[i1] = u->IcellIDX->data[i1];
  }

  b_y = NULL;
  m1 = emlrtCreateNumericArray(2, *(int32_T (*)[1])o_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m1);
  i1 = 0;
  loopUpperBound = u->IcellIDX->size[1];
  emxFree_real_T(&o_u);
  for (i = 0; i < loopUpperBound; i++) {
    pData[i1] = u->IcellIDX->data[u->IcellIDX->size[0] * i];
    i1++;
  }

  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "IcellIDX", b_y, 13);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  return y;
}

static struct1_T f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  struct1_T y;
  emlrtMsgIdentifier thisId;
  static const char * fieldNames[2] = { "dt", "SimTime" };

  static const int32_T dims = 0;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(emlrtRootTLSGlobal, parentId, u, 2, fieldNames, 0U,
    &dims);
  thisId.fIdentifier = "dt";
  y.dt = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b(emlrtRootTLSGlobal, u,
    0, 0, "dt")), &thisId);
  thisId.fIdentifier = "SimTime";
  y.SimTime = c_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2017b
    (emlrtRootTLSGlobal, u, 0, 1, "SimTime")), &thisId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T g_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 0U,
    &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void h_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[2])
{
  static const int32_T dims[2] = { 1, 2 };

  int32_T i2;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  for (i2 = 0; i2 < 2; i2++) {
    ret[i2] = (*(real_T (*)[2])emlrtMxGetData(src))[i2];
  }

  emlrtDestroyArray(&src);
}

void CAdLIFfunction_STDP_api(const mxArray * const prhs[2], int32_T nlhs, const
  mxArray *plhs[1])
{
  struct2_T SimValues;
  struct0_T PopParams;
  struct1_T TimeParams;
  (void)nlhs;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInitStruct_struct2_T(&SimValues, true);

  /* Marshall function inputs */
  emlrt_marshallIn(emlrtAliasP(prhs[0]), "PopParams", &PopParams);
  TimeParams = e_emlrt_marshallIn(emlrtAliasP(prhs[1]), "TimeParams");

  /* Invoke the target function */
  CAdLIFfunction_STDP(&PopParams, &TimeParams, &SimValues);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(&SimValues);
  emxFreeStruct_struct2_T(&SimValues);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (_coder_CAdLIFfunction_STDP_api.cu) */
