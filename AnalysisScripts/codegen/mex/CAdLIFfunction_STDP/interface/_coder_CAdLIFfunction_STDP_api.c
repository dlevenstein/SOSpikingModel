/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_CAdLIFfunction_STDP_api.c
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

/* Variable Definitions */
static emlrtRTEInfo oh_emlrtRTEI = { 1,/* lineNo */
  1,                                   /* colNo */
  "_coder_CAdLIFfunction_STDP_api",    /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct0_T *y);
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static const mxArray *c_emlrt_marshallOut(const emlrtStack *sp, const struct2_T *
  u);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[2]);
static const mxArray *d_emlrt_marshallOut(const emxArray_real_T *u);
static struct1_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *TimeParams, const char_T *identifier);
static const mxArray *e_emlrt_marshallOut(const emxArray_real_T *u);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *PopParams,
  const char_T *identifier, struct0_T *y);
static struct1_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId);
static real_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[2]);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  static const char * fieldNames[31] = { "I_e", "sigma", "theta", "EPopNum",
    "IPopNum", "E_L", "g_L", "C", "V_th", "V_reset", "t_ref", "E_e", "E_i",
    "tau_s", "E_w", "b_w", "b", "delta_T", "w_r", "gwnorm", "Wee", "Wii", "Wie",
    "Wei", "Kee", "Kii", "Kie", "Kei", "LearningRate", "TargetRate", "tauSTDP" };

  static const int32_T dims = 0;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 31, fieldNames, 0U, &dims);
  thisId.fIdentifier = "I_e";
  y->I_e = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 0,
    "I_e")), &thisId);
  thisId.fIdentifier = "sigma";
  y->sigma = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 1,
    "sigma")), &thisId);
  thisId.fIdentifier = "theta";
  y->theta = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 2,
    "theta")), &thisId);
  thisId.fIdentifier = "EPopNum";
  y->EPopNum = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 3,
    "EPopNum")), &thisId);
  thisId.fIdentifier = "IPopNum";
  y->IPopNum = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 4,
    "IPopNum")), &thisId);
  thisId.fIdentifier = "E_L";
  d_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 5, "E_L")),
                     &thisId, y->E_L);
  thisId.fIdentifier = "g_L";
  d_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 6, "g_L")),
                     &thisId, y->g_L);
  thisId.fIdentifier = "C";
  d_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 7, "C")),
                     &thisId, y->C);
  thisId.fIdentifier = "V_th";
  d_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 8, "V_th")),
                     &thisId, y->V_th);
  thisId.fIdentifier = "V_reset";
  d_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 9, "V_reset")),
                     &thisId, y->V_reset);
  thisId.fIdentifier = "t_ref";
  y->t_ref = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 10,
    "t_ref")), &thisId);
  thisId.fIdentifier = "E_e";
  y->E_e = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 11,
    "E_e")), &thisId);
  thisId.fIdentifier = "E_i";
  y->E_i = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 12,
    "E_i")), &thisId);
  thisId.fIdentifier = "tau_s";
  d_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 13, "tau_s")),
                     &thisId, y->tau_s);
  thisId.fIdentifier = "E_w";
  y->E_w = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 14,
    "E_w")), &thisId);
  thisId.fIdentifier = "b_w";
  y->b_w = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 15,
    "b_w")), &thisId);
  thisId.fIdentifier = "b";
  y->b = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 16, "b")),
    &thisId);
  thisId.fIdentifier = "delta_T";
  y->delta_T = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0,
    17, "delta_T")), &thisId);
  thisId.fIdentifier = "w_r";
  y->w_r = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 18,
    "w_r")), &thisId);
  thisId.fIdentifier = "gwnorm";
  y->gwnorm = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 19,
    "gwnorm")), &thisId);
  thisId.fIdentifier = "Wee";
  y->Wee = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 20,
    "Wee")), &thisId);
  thisId.fIdentifier = "Wii";
  y->Wii = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 21,
    "Wii")), &thisId);
  thisId.fIdentifier = "Wie";
  y->Wie = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 22,
    "Wie")), &thisId);
  thisId.fIdentifier = "Wei";
  y->Wei = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 23,
    "Wei")), &thisId);
  thisId.fIdentifier = "Kee";
  y->Kee = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 24,
    "Kee")), &thisId);
  thisId.fIdentifier = "Kii";
  y->Kii = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 25,
    "Kii")), &thisId);
  thisId.fIdentifier = "Kie";
  y->Kie = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 26,
    "Kie")), &thisId);
  thisId.fIdentifier = "Kei";
  y->Kei = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 27,
    "Kei")), &thisId);
  thisId.fIdentifier = "LearningRate";
  y->LearningRate = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u,
    0, 28, "LearningRate")), &thisId);
  thisId.fIdentifier = "TargetRate";
  y->TargetRate = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0,
    29, "TargetRate")), &thisId);
  thisId.fIdentifier = "tauSTDP";
  y->tauSTDP = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0,
    30, "tauSTDP")), &thisId);
  emlrtDestroyArray(&u);
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = g_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *c_emlrt_marshallOut(const emlrtStack *sp, const struct2_T *
  u)
{
  const mxArray *y;
  emxArray_real_T *b_u;
  static const char * sv0[14] = { "t", "V", "g_w", "g_e", "g_i", "s", "w", "a_w",
    "Input", "t_weight", "WeightMat", "spikes", "EcellIDX", "IcellIDX" };

  int32_T i8;
  int32_T loop_ub;
  const mxArray *b_y;
  const mxArray *m3;
  real_T *pData;
  emxArray_real32_T *c_u;
  int32_T i;
  int32_T b_i;
  real32_T *b_pData;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T2(sp, &b_u, 3, (emlrtRTEInfo *)NULL, true);
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 14, sv0));
  emlrtSetFieldR2017b(y, 0, "t", d_emlrt_marshallOut(u->t), 0);
  emlrtSetFieldR2017b(y, 0, "V", e_emlrt_marshallOut(u->V), 1);
  emlrtSetFieldR2017b(y, 0, "g_w", e_emlrt_marshallOut(u->g_w), 2);
  emlrtSetFieldR2017b(y, 0, "g_e", e_emlrt_marshallOut(u->g_e), 3);
  emlrtSetFieldR2017b(y, 0, "g_i", e_emlrt_marshallOut(u->g_i), 4);
  emlrtSetFieldR2017b(y, 0, "s", e_emlrt_marshallOut(u->s), 5);
  emlrtSetFieldR2017b(y, 0, "w", e_emlrt_marshallOut(u->w), 6);
  emlrtSetFieldR2017b(y, 0, "a_w", e_emlrt_marshallOut(u->a_w), 7);
  emlrtSetFieldR2017b(y, 0, "Input", e_emlrt_marshallOut(u->Input), 8);
  emlrtSetFieldR2017b(y, 0, "t_weight", d_emlrt_marshallOut(u->t_weight), 9);
  i8 = b_u->size[0] * b_u->size[1] * b_u->size[2];
  b_u->size[0] = u->WeightMat->size[0];
  b_u->size[1] = u->WeightMat->size[1];
  b_u->size[2] = u->WeightMat->size[2];
  emxEnsureCapacity_real_T2(sp, b_u, i8, (emlrtRTEInfo *)NULL);
  loop_ub = u->WeightMat->size[0] * u->WeightMat->size[1] * u->WeightMat->size[2];
  for (i8 = 0; i8 < loop_ub; i8++) {
    b_u->data[i8] = u->WeightMat->data[i8];
  }

  b_y = NULL;
  m3 = emlrtCreateNumericArray(3, *(int32_T (*)[1])b_u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m3);
  i8 = 0;
  loop_ub = 0;
  emxFree_real_T(sp, &b_u);
  while (loop_ub < u->WeightMat->size[2]) {
    for (i = 0; i < u->WeightMat->size[1]; i++) {
      for (b_i = 0; b_i < u->WeightMat->size[0]; b_i++) {
        pData[i8] = u->WeightMat->data[(b_i + u->WeightMat->size[0] * i) +
          u->WeightMat->size[0] * u->WeightMat->size[1] * loop_ub];
        i8++;
      }
    }

    loop_ub++;
  }

  emxInit_real32_T(sp, &c_u, 2, (emlrtRTEInfo *)NULL, true);
  emlrtAssign(&b_y, m3);
  emlrtSetFieldR2017b(y, 0, "WeightMat", b_y, 10);
  i8 = c_u->size[0] * c_u->size[1];
  c_u->size[0] = u->spikes->size[0];
  c_u->size[1] = 2;
  emxEnsureCapacity_real32_T(sp, c_u, i8, (emlrtRTEInfo *)NULL);
  loop_ub = u->spikes->size[0] * u->spikes->size[1];
  for (i8 = 0; i8 < loop_ub; i8++) {
    c_u->data[i8] = u->spikes->data[i8];
  }

  b_y = NULL;
  m3 = emlrtCreateNumericArray(2, *(int32_T (*)[1])c_u->size, mxSINGLE_CLASS,
    mxREAL);
  b_pData = (real32_T *)emlrtMxGetData(m3);
  i8 = 0;
  emxFree_real32_T(sp, &c_u);
  for (loop_ub = 0; loop_ub < 2; loop_ub++) {
    for (i = 0; i < u->spikes->size[0]; i++) {
      b_pData[i8] = u->spikes->data[i + u->spikes->size[0] * loop_ub];
      i8++;
    }
  }

  emlrtAssign(&b_y, m3);
  emlrtSetFieldR2017b(y, 0, "spikes", b_y, 11);
  emlrtSetFieldR2017b(y, 0, "EcellIDX", d_emlrt_marshallOut(u->EcellIDX), 12);
  emlrtSetFieldR2017b(y, 0, "IcellIDX", d_emlrt_marshallOut(u->IcellIDX), 13);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return y;
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[2])
{
  h_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *d_emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  const mxArray *m4;
  real_T *pData;
  int32_T i9;
  int32_T i;
  y = NULL;
  m4 = emlrtCreateNumericArray(2, *(int32_T (*)[1])u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m4);
  i9 = 0;
  for (i = 0; i < u->size[1]; i++) {
    pData[i9] = u->data[u->size[0] * i];
    i9++;
  }

  emlrtAssign(&y, m4);
  return y;
}

static struct1_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *TimeParams, const char_T *identifier)
{
  struct1_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(TimeParams), &thisId);
  emlrtDestroyArray(&TimeParams);
  return y;
}

static const mxArray *e_emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  const mxArray *m5;
  real_T *pData;
  int32_T i10;
  int32_T i;
  int32_T b_i;
  y = NULL;
  m5 = emlrtCreateNumericArray(2, *(int32_T (*)[1])u->size, mxDOUBLE_CLASS,
    mxREAL);
  pData = emlrtMxGetPr(m5);
  i10 = 0;
  for (i = 0; i < u->size[1]; i++) {
    for (b_i = 0; b_i < u->size[0]; b_i++) {
      pData[i10] = u->data[b_i + u->size[0] * i];
      i10++;
    }
  }

  emlrtAssign(&y, m5);
  return y;
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *PopParams,
  const char_T *identifier, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(PopParams), &thisId, y);
  emlrtDestroyArray(&PopParams);
}

static struct1_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId)
{
  struct1_T y;
  emlrtMsgIdentifier thisId;
  static const char * fieldNames[2] = { "dt", "SimTime" };

  static const int32_T dims = 0;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 2, fieldNames, 0U, &dims);
  thisId.fIdentifier = "dt";
  y.dt = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 0, "dt")),
    &thisId);
  thisId.fIdentifier = "SimTime";
  y.SimTime = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 1,
    "SimTime")), &thisId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[2])
{
  static const int32_T dims[2] = { 1, 2 };

  int32_T i11;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  for (i11 = 0; i11 < 2; i11++) {
    ret[i11] = (*(real_T (*)[2])emlrtMxGetData(src))[i11];
  }

  emlrtDestroyArray(&src);
}

void CAdLIFfunction_STDP_api(const mxArray * const prhs[2], int32_T nlhs, const
  mxArray *plhs[1])
{
  struct2_T SimValues;
  struct0_T PopParams;
  struct1_T TimeParams;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInitStruct_struct2_T(&st, &SimValues, &oh_emlrtRTEI, true);

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "PopParams", &PopParams);
  TimeParams = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "TimeParams");

  /* Invoke the target function */
  CAdLIFfunction_STDP(&st, &PopParams, &TimeParams, &SimValues);

  /* Marshall function outputs */
  plhs[0] = c_emlrt_marshallOut(&st, &SimValues);
  emxFreeStruct_struct2_T(&st, &SimValues);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_CAdLIFfunction_STDP_api.c) */
