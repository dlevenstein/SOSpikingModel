/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * createRecorder.c
 *
 * Code generation for function 'createRecorder'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "createRecorder.h"
#include "CAdLIFfunction_STDP_emxutil.h"
#include "CAdLIFfunction_STDP_data.h"

/* Variable Definitions */
static emlrtRSInfo gb_emlrtRSI = { 5,  /* lineNo */
  "createRecorder",                    /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\MiscUtilities\\createRecorder.m"/* pathName */
};

static emlrtRTEInfo gh_emlrtRTEI = { 5,/* lineNo */
  1,                                   /* colNo */
  "createRecorder",                    /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\MiscUtilities\\createRecorder.m"/* pName */
};

static emlrtRTEInfo hh_emlrtRTEI = { 11,/* lineNo */
  1,                                   /* colNo */
  "createRecorder",                    /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\MiscUtilities\\createRecorder.m"/* pName */
};

static emlrtBCInfo ic_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  8,                                   /* colNo */
  "tSAVE",                             /* aName */
  "createRecorder",                    /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\MiscUtilities\\createRecorder.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  37,                                  /* colNo */
  "tSAVE",                             /* aName */
  "createRecorder",                    /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\MiscUtilities\\createRecorder.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  28,                                  /* lineNo */
  9,                                   /* colNo */
  "recordVALs",                        /* aName */
  "createRecorder",                    /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\MiscUtilities\\createRecorder.m",/* pName */
  0                                    /* checkKind */
};

/* Function Definitions */
void createRecorder(const emlrtStack *sp, const real_T recordIntervals[4],
                    real_T TimeParams_dt, real_T TimeParams_SimTime,
                    emxArray_real_T *recordVALs)
{
  emxArray_real_T *tSAVE;
  int32_T k;
  real_T ndbl;
  real_T apnd;
  real_T cdiff;
  int32_T nm1d2;
  int32_T n;
  real_T saveINT[4];
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &gb_emlrtRSI;
  emxInit_real_T(&st, &tSAVE, 2, &gh_emlrtRTEI, true);
  if (muDoubleScalarIsNaN(TimeParams_dt) || muDoubleScalarIsNaN
      (TimeParams_SimTime)) {
    k = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = 1;
    emxEnsureCapacity_real_T(&st, tSAVE, k, &gh_emlrtRTEI);
    tSAVE->data[0] = rtNaN;
  } else if ((TimeParams_dt == 0.0) || ((0.0 < TimeParams_SimTime) &&
              (TimeParams_dt < 0.0)) || ((TimeParams_SimTime < 0.0) &&
              (TimeParams_dt > 0.0))) {
    k = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = 0;
    emxEnsureCapacity_real_T(&st, tSAVE, k, &gh_emlrtRTEI);
  } else if (muDoubleScalarIsInf(TimeParams_SimTime) && (muDoubleScalarIsInf
              (TimeParams_dt) || (0.0 == TimeParams_SimTime))) {
    k = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = 1;
    emxEnsureCapacity_real_T(&st, tSAVE, k, &gh_emlrtRTEI);
    tSAVE->data[0] = rtNaN;
  } else if (muDoubleScalarIsInf(TimeParams_dt)) {
    k = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = 1;
    emxEnsureCapacity_real_T(&st, tSAVE, k, &gh_emlrtRTEI);
    tSAVE->data[0] = 0.0;
  } else if (muDoubleScalarFloor(TimeParams_dt) == TimeParams_dt) {
    k = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = (int32_T)muDoubleScalarFloor(TimeParams_SimTime /
      TimeParams_dt) + 1;
    emxEnsureCapacity_real_T(&st, tSAVE, k, &gh_emlrtRTEI);
    nm1d2 = (int32_T)muDoubleScalarFloor(TimeParams_SimTime / TimeParams_dt);
    for (k = 0; k <= nm1d2; k++) {
      tSAVE->data[tSAVE->size[0] * k] = TimeParams_dt * (real_T)k;
    }
  } else {
    b_st.site = &hb_emlrtRSI;
    ndbl = muDoubleScalarFloor(TimeParams_SimTime / TimeParams_dt + 0.5);
    apnd = ndbl * TimeParams_dt;
    if (TimeParams_dt > 0.0) {
      cdiff = apnd - TimeParams_SimTime;
    } else {
      cdiff = TimeParams_SimTime - apnd;
    }

    if (muDoubleScalarAbs(cdiff) < 4.4408920985006262E-16 * muDoubleScalarAbs
        (TimeParams_SimTime)) {
      ndbl++;
      apnd = TimeParams_SimTime;
    } else if (cdiff > 0.0) {
      apnd = (ndbl - 1.0) * TimeParams_dt;
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      n = (int32_T)ndbl;
    } else {
      n = 0;
    }

    c_st.site = &ib_emlrtRSI;
    if (ndbl > 2.147483647E+9) {
      emlrtErrorWithMessageIdR2018a(&c_st, &bi_emlrtRTEI,
        "Coder:MATLAB:pmaxsize", "Coder:MATLAB:pmaxsize", 0);
    }

    k = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = n;
    emxEnsureCapacity_real_T(&b_st, tSAVE, k, &f_emlrtRTEI);
    if (n > 0) {
      tSAVE->data[0] = 0.0;
      if (n > 1) {
        tSAVE->data[n - 1] = apnd;
        nm1d2 = (n - 1) / 2;
        for (k = 1; k < nm1d2; k++) {
          ndbl = (real_T)k * TimeParams_dt;
          tSAVE->data[k] = ndbl;
          tSAVE->data[(n - k) - 1] = apnd - ndbl;
        }

        if (nm1d2 << 1 == n - 1) {
          tSAVE->data[nm1d2] = apnd / 2.0;
        } else {
          ndbl = (real_T)nm1d2 * TimeParams_dt;
          tSAVE->data[nm1d2] = ndbl;
          tSAVE->data[nm1d2 + 1] = apnd - ndbl;
        }
      }
    }
  }

  k = recordVALs->size[0] * recordVALs->size[1];
  recordVALs->size[0] = 1;
  recordVALs->size[1] = tSAVE->size[1];
  emxEnsureCapacity_real_T(sp, recordVALs, k, &hh_emlrtRTEI);
  nm1d2 = tSAVE->size[1];
  for (k = 0; k < nm1d2; k++) {
    recordVALs->data[k] = 0.0;
  }

  for (k = 0; k < 4; k++) {
    saveINT[k] = rtNaN;
  }

  nm1d2 = 0;
  while (nm1d2 < 2) {
    saveINT[nm1d2 << 1] = recordIntervals[nm1d2 << 1];
    saveINT[1 + (nm1d2 << 1)] = recordIntervals[1 + (nm1d2 << 1)];
    nm1d2++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  nm1d2 = 0;
  while (nm1d2 < 2) {
    n = 1;
    while (n - 1 <= tSAVE->size[1] - 2) {
      k = tSAVE->size[1];
      if (!((n >= 1) && (n <= k))) {
        emlrtDynamicBoundsCheckR2012b(n, 1, k, &ic_emlrtBCI, sp);
      }

      if (tSAVE->data[n - 1] >= saveINT[nm1d2 << 1]) {
        k = tSAVE->size[1];
        if (!((n >= 1) && (n <= k))) {
          emlrtDynamicBoundsCheckR2012b(n, 1, k, &jc_emlrtBCI, sp);
        }

        if (tSAVE->data[n - 1] <= saveINT[1 + (nm1d2 << 1)]) {
          k = recordVALs->size[1];
          if (!((n >= 1) && (n <= k))) {
            emlrtDynamicBoundsCheckR2012b(n, 1, k, &kc_emlrtBCI, sp);
          }

          recordVALs->data[n - 1] = 1.0;
        }
      }

      n++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    nm1d2++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(sp, &tSAVE);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (createRecorder.c) */
