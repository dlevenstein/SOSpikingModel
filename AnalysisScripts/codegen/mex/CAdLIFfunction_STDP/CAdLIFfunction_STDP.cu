/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * CAdLIFfunction_STDP.cu
 *
 * Code generation for function 'CAdLIFfunction_STDP'
 *
 */

/* Include files */
#include "MWCudaDimUtility.h"
#include <stdlib.h>
#include <math.h>
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "CAdLIFfunction_STDP_emxutil.h"
#include "CAdLIFfunction_STDP_data.h"

/* Variable Definitions */
static emlrtRTEInfo emlrtRTEI = { 403, /* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtMCInfo emlrtMCI = { 537,   /* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtMCInfo b_emlrtMCI = { 538, /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtMCInfo c_emlrtMCI = { 539, /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtMCInfo d_emlrtMCI = { 540, /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtMCInfo e_emlrtMCI = { 541, /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtMCInfo f_emlrtMCI = { 541, /* lineNo */
  25,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtMCInfo g_emlrtMCI = { 541, /* lineNo */
  45,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtMCInfo h_emlrtMCI = { 542, /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtMCInfo i_emlrtMCI = { 542, /* lineNo */
  32,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

/* Function Declarations */
static __global__ void CAdLIFfunction_STDP_kernel1(real_T *recordIntervals,
  real_T *saveINT);
static void b_plot(const mxArray *b, const mxArray *c, const mxArray *d,
                   emlrtMCInfo *location);
static void checkCudaError(cudaError_t errCode, const char * file, uint32_T line);
static void figure(emlrtMCInfo *location);
static void hold(const mxArray *b, emlrtMCInfo *location);
static void plot(const mxArray *b, const mxArray *c, const mxArray *d, const
                 mxArray *e, const mxArray *f, emlrtMCInfo *location);
static real_T rt_roundd_snf(real_T u);
static void title(const mxArray *b, emlrtMCInfo *location);
static void xlabel(const mxArray *b, emlrtMCInfo *location);
static void xlim(const mxArray *b, emlrtMCInfo *location);
static void ylabel(const mxArray *b, emlrtMCInfo *location);
static void ylim(const mxArray *b, emlrtMCInfo *location);

/* Function Definitions */
static __global__ __launch_bounds__(32, 1) void CAdLIFfunction_STDP_kernel1
  (real_T *recordIntervals, real_T *saveINT)
{
  uint32_T threadId;
  int32_T ii;
  threadId = (uint32_T)mwGetGlobalThreadIndex();
  ii = (int32_T)threadId;
  if (!(ii >= 2)) {
    saveINT[ii << 1] = recordIntervals[ii << 1];
    saveINT[1 + (ii << 1)] = recordIntervals[1 + (ii << 1)];
  }
}

static void b_plot(const mxArray *b, const mxArray *c, const mxArray *d,
                   emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  pArrays[0] = b;
  pArrays[1] = c;
  pArrays[2] = d;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 3, pArrays, "plot", true,
                        location);
}

static void checkCudaError(cudaError_t errCode, const char * file, uint32_T line)
{
  emlrtRTEInfo rtInfo;
  char_T *pn;
  char_T *fn;
  char_T *brk;
  uint32_T len;
  if (errCode != cudaSuccess) {
    len = strlen(file);
    pn = (char_T *)calloc(len + 1U, 1U);
    fn = (char_T *)calloc(len + 1U, 1U);
    memcpy(pn, file, len);
    memcpy(fn, file, len);
    brk = strrchr(fn, '.');
    *brk = '\x00';
    brk = strrchr(fn, '/');
    if (brk == NULL) {
      brk = strrchr(fn, '\\');
    }

    if (brk == NULL) {
      brk = fn;
    } else {
      brk++;
    }

    rtInfo.lineNo = (int32_T)line;
    rtInfo.colNo = 0;
    rtInfo.fName = brk;
    rtInfo.pName = pn;
    emlrtCUDAError(errCode, cudaGetErrorName(errCode), cudaGetErrorString
                   (errCode), &rtInfo, emlrtRootTLSGlobal);
  }
}

static void figure(emlrtMCInfo *location)
{
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 0, NULL, "figure", true,
                        location);
}

static void hold(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 1, &pArray, "hold", true,
                        location);
}

static void plot(const mxArray *b, const mxArray *c, const mxArray *d, const
                 mxArray *e, const mxArray *f, emlrtMCInfo *location)
{
  const mxArray *pArrays[5];
  pArrays[0] = b;
  pArrays[1] = c;
  pArrays[2] = d;
  pArrays[3] = e;
  pArrays[4] = f;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 5, pArrays, "plot", true,
                        location);
}

static real_T rt_roundd_snf(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

static void title(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 1, &pArray, "title", true,
                        location);
}

static void xlabel(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 1, &pArray, "xlabel", true,
                        location);
}

static void xlim(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 1, &pArray, "xlim", true,
                        location);
}

static void ylabel(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 1, &pArray, "ylabel", true,
                        location);
}

static void ylim(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 1, &pArray, "ylim", true,
                        location);
}

void CAdLIFfunction_STDP(const struct0_T *PopParams, const struct1_T *TimeParams,
  struct2_T *SimValues)
{
  real_T recordIntervals[4];
  emxArray_real_T *tSAVE;
  int32_T i0;
  emxArray_int8_T *recordVALs;
  real_T ndbl;
  real_T apnd;
  real_T cdiff;
  int32_T loopUpperBound;
  real_T saveINT[4];
  int32_T n;
  int32_T ii;
  int32_T loop_ub;
  real_T EPopNum;
  int32_T nm1d2;
  int32_T k;
  real_T PopNum;
  real_T dt;
  emxArray_real_T *r0;
  int32_T varargin_2;
  emxArray_real_T *r1;
  emxArray_real_T *r2;
  emxArray_real_T *EE_mat;
  emxArray_real_T *II_mat;
  emxArray_real_T *IE_mat;
  emxArray_real_T *EI_mat;
  emxArray_real_T *Ecells;
  emxArray_real_T *y;
  emxArray_boolean_T *EcellIDX;
  emxArray_real_T *Icells;
  emxArray_real_T *b_y;
  real_T absa;
  emxArray_boolean_T *IcellIDX;
  emxArray_int32_T *r3;
  emxArray_int32_T *r4;
  emxArray_real_T *r;
  uint32_T uv0[2];
  emxArray_boolean_T *d;
  emxArray_boolean_T *r5;
  int32_T iv0[2];
  int32_T b_loopUpperBound;
  int32_T mA;
  emxArray_int32_T *r6;
  emxArray_int32_T *r7;
  emxArray_int32_T *r8;
  emxArray_real_T *b_r;
  emxArray_boolean_T *b_d;
  emxArray_boolean_T *r9;
  emxArray_int32_T *r10;
  emxArray_int32_T *r11;
  emxArray_int32_T *r12;
  emxArray_real_T *c_r;
  emxArray_int32_T *r13;
  emxArray_int32_T *r14;
  emxArray_real_T *d_r;
  emxArray_boolean_T *isconnected;
  emxArray_real_T *E_L;
  emxArray_real_T *g_L;
  emxArray_real_T *C;
  emxArray_real_T *I_e;
  emxArray_real_T *V_th;
  emxArray_real_T *V_reset;
  emxArray_real_T *t_ref;
  emxArray_real_T *sigma;
  emxArray_real_T *theta;
  emxArray_real_T *E_w;
  emxArray_real_T *b_w;
  emxArray_real_T *delta_T;
  emxArray_real_T *gwnorm;
  emxArray_real_T *w_r;
  emxArray_real_T *b;
  emxArray_real_T *E_e;
  emxArray_real_T *E_i;
  emxArray_real_T *tau_s;
  emxArray_real_T *ELearningRate;
  emxArray_real_T *ILearningRate;
  emxArray_real_T *tauSTDP;
  emxArray_real_T *alpha;
  emxArray_real_T *V;
  emxArray_real_T *g_e;
  emxArray_real_T *g_i;
  emxArray_real_T *g_w;
  emxArray_real_T *a_w;
  emxArray_real_T *s;
  emxArray_real_T *w;
  emxArray_real_T *X_t;
  emxArray_real_T *t_r;
  emxArray_real_T *x;
  emxArray_boolean_T *b_x;
  emxArray_int32_T *b_ii;
  int32_T nx;
  int32_T idx;
  emxArray_real32_T *spikes;
  emxArray_int32_T *r15;
  emxArray_int32_T *r16;
  emxArray_real_T *c_x;
  emxArray_real_T *r17;
  emxArray_real_T *dX;
  boolean_T p;
  emxArray_real_T *e_r;
  uint32_T savecounter;
  uint32_T weightcounter;
  emxArray_real_T *PreIspikes;
  emxArray_real_T *PostEspikes;
  emxArray_real_T *r18;
  emxArray_real_T *r19;
  emxArray_real_T *r20;
  emxArray_int32_T *r21;
  emxArray_int32_T *r22;
  emxArray_int32_T *r23;
  emxArray_int32_T *r24;
  emxArray_int32_T *r25;
  emxArray_int32_T *r26;
  emxArray_int32_T *r27;
  emxArray_boolean_T *d_x;
  emxArray_real_T *e_x;
  emxArray_real_T *f_x;
  emxArray_real_T *g_x;
  emxArray_boolean_T *h_x;
  emxArray_boolean_T *i_x;
  emxArray_int32_T *c_ii;
  cell_wrap_1 reshapes[2];
  emxArray_boolean_T *j_x;
  emxArray_real_T *b_C;
  emxArray_real_T *c_C;
  emxArray_real_T *d_C;
  emxArray_real_T *e_C;
  emxArray_real_T *b_s;
  emxArray_real_T *k_x;
  emxArray_real_T *b_EI_mat;
  emxArray_real_T *c_EI_mat;
  emxArray_real_T *b_t_r;
  int32_T l_x;
  int32_T tt;
  real_T f_r;
  real_T g_r;
  const mxArray *c_y;
  const mxArray *m0;
  emxArray_int32_T *b_idx;
  boolean_T b0;
  int32_T br;
  emxArray_boolean_T *b_b;
  emxArray_real32_T *b_spikes;
  int32_T nA;
  emxArray_real32_T *u;
  emxArray_boolean_T *r28;
  real32_T *pData;
  emxArray_real32_T *b_u;
  const mxArray *d_y;
  const mxArray *e_y;
  static const int32_T iv1[2] = { 1, 2 };

  static const char_T c_u[2] = { 'k', '.' };

  const mxArray *f_y;
  static const int32_T iv2[2] = { 1, 10 };

  static const char_T d_u[10] = { 'M', 'a', 'r', 'k', 'e', 'r', 's', 'i', 'z',
    'e' };

  const mxArray *g_y;
  static const int32_T iv3[2] = { 1, 2 };

  static const char_T e_u[2] = { 'o', 'n' };

  static const int32_T iv4[2] = { 1, 2 };

  real_T *b_pData;
  real_T V0range[2];
  static const int32_T iv5[2] = { 1, 2 };

  static const int32_T iv6[2] = { 1, 9 };

  static const char_T f_u[9] = { 'T', 'i', 'm', 'e', ' ', '(', 'm', 's', ')' };

  static const int32_T iv7[2] = { 1, 9 };

  static const char_T g_u[9] = { 'N', 'e', 'u', 'r', 'o', 'n', ' ', 'I', 'D' };

  static const int32_T iv8[2] = { 1, 11 };

  static const char_T h_u[11] = { 'R', 'a', 's', 't', 'e', 'r', ' ', 'P', 'l',
    'o', 't' };

  static const int32_T iv9[2] = { 1, 2 };

  static const int32_T iv10[2] = { 1, 2 };

  emxArray_boolean_T *c_idx;
  emxArray_real32_T *c_spikes;
  real_T *gpu_recordIntervals;
  real_T *gpu_saveINT;
  boolean_T saveINT_dirtyOnGpu;
  boolean_T exitg1;

#define CUDACHECK(errCall)             checkCudaError(errCall, __FILE__, __LINE__)

  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  CUDACHECK(cudaMalloc(&gpu_saveINT, 32ULL));
  CUDACHECK(cudaMalloc(&gpu_recordIntervals, 32ULL));
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  /* Conductance-Based Adapting LIF Model, Euler Mayurama   implementation  */
  /* with Conductance-based Jump-decay STDP synapses */
  /* by Jonathan Gornet and DLevenstein */
  /* Last update: 4/8/2018 */
  /* INPUTS */
  /*    PopParams       a structure that gives all the parameters of the population */
  /*        .EPopNum	Number of excitatory neurons */
  /*        .IPopNum	Number of inhibitory neurons */
  /*        .E_L     	Reversal potential of the leak current (i.e. Vrest) */
  /*        .g_L     	Conductance of the leak current  */
  /*        .C          Membrane Capacitance */
  /*        .I_e        Input current to the population. Can either be a */
  /*                    constant, input to [E I] populations, */
  /*                    or a function I_e(t) that returns input at time t */
  /*                    time t. Add:  */
  /*        .V_th       Membrane Threshold */
  /*        .V_reset    Reset Potential */
  /*  */
  /*        .sigma      Standard deviation of noise */
  /*        .theta      TimeScale of noise */
  /*   */
  /*        .E_e        Reversal potential of excitatory synapses */
  /*        .E_i        Reversal potential of inhibitory synapses */
  /*        .tau_s      Time of synaptic decay */
  /*   */
  /*        .tau_a      Adaptation time constant */
  /*        .t_ref      Refractory period */
  /*        .delta_T    Adaptation threshold softness */
  /*        .gwnorm     Adaptation normalizer */
  /*        .b          Adaptation activation strength */
  /*        .bw         Time of adaptative decay */
  /*        .w_r        Adaptation Rest */
  /*  */
  /*                    SYNAPTIC WEIGHT (conductance jump: nS?) */
  /*        .Wee        E->E synapse weight */
  /*        .Wii        I->I synapse weight */
  /*        .Wie        E->I synapse weight */
  /*        .Wei        I->E synapse weight */
  /*                    CONNECTION PROBABILITY (Expected In-Degree) */
  /*        .Kee        E->E */
  /*        .Kii        I->I */
  /*        .Kie        E->I */
  /*        .Kei        I->E */
  /*  */
  /*        .p0spike    (optional) proportion of neurons spiking at t0 (default:0) */
  /*    TimeParams */
  /*        .dt        timestep (ms) */
  /*        .SimTime   total simulation time (ms) */
  /*    'showfig'       (optional) show the figure? (default:true) */
  /*    'showprogress'  (optional) show time counter of progress (default:false) */
  /*    'onsettime'     (optional) duration of (removed?) onset time (default: 0ms) */
  /*    'save_dt'       (optional) dt for the saved output (default: 0.1ms) */
  /*  */
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  /* Parse optional inputs */
  /*  p = inputParser; */
  /*  addParameter(p,'showfig',true,@islogical) */
  /*  addParameter(p,'showprogress',false,@islogical) */
  /*  addParameter(p,'onsettime',0,@isnumeric) */
  /*  addParameter(p,'save_dt',0.5,@isnumeric) */
  /*  addParameter(p,'save_weights',10,@isnumeric) */
  /*  addParameter(p,'cellout',false,@islogical) */
  /*  addParameter(p,'recordInterval',[],@isnumeric) */
  /*  parse(p,varargin{:}) */
  /*  SHOWFIG = p.Results.showfig; */
  /*  SHOWPROGRESS = p.Results.showprogress; */
  /*  onsettime = p.Results.onsettime; */
  /*  save_dt = p.Results.save_dt; */
  /*  save_weights = p.Results.save_weights; */
  /*  cellout = p.Results.cellout; */
  /*  recordIntervals = p.Results.recordInterval; */
  recordIntervals[0] = 0.0;
  recordIntervals[2] = TimeParams->SimTime - 1000.0;
  recordIntervals[1] = 1000.0;
  recordIntervals[3] = TimeParams->SimTime;
  emxInit_real_T(&tSAVE, 2, true);
  if (rtIsNaN(TimeParams->dt) || rtIsNaN(TimeParams->SimTime)) {
    i0 = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = 1;
    emxEnsureCapacity_real_T(tSAVE, i0);
    tSAVE->data[0] = rtNaN;
  } else if ((TimeParams->dt == 0.0) || ((0.0 < TimeParams->SimTime) &&
              (TimeParams->dt < 0.0)) || ((TimeParams->SimTime < 0.0) &&
              (TimeParams->dt > 0.0))) {
    i0 = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = 0;
    emxEnsureCapacity_real_T(tSAVE, i0);
  } else if (rtIsInf(TimeParams->SimTime) && (rtIsInf(TimeParams->dt) || (0.0 ==
    TimeParams->SimTime))) {
    i0 = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = 1;
    emxEnsureCapacity_real_T(tSAVE, i0);
    tSAVE->data[0] = rtNaN;
  } else if (rtIsInf(TimeParams->dt)) {
    i0 = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = 1;
    emxEnsureCapacity_real_T(tSAVE, i0);
    tSAVE->data[0] = 0.0;
  } else if (floor(TimeParams->dt) == TimeParams->dt) {
    i0 = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = (int32_T)floor(TimeParams->SimTime / TimeParams->dt) + 1;
    emxEnsureCapacity_real_T(tSAVE, i0);
    for (loopUpperBound = 0; loopUpperBound <= (int32_T)(TimeParams->SimTime /
          TimeParams->dt); loopUpperBound++) {
      tSAVE->data[tSAVE->size[0] * loopUpperBound] = TimeParams->dt * (real_T)
        loopUpperBound;
    }
  } else {
    ndbl = floor(TimeParams->SimTime / TimeParams->dt + 0.5);
    apnd = ndbl * TimeParams->dt;
    if (TimeParams->dt > 0.0) {
      cdiff = apnd - TimeParams->SimTime;
    } else {
      cdiff = TimeParams->SimTime - apnd;
    }

    if (fabs(cdiff) < 4.4408920985006262E-16 * fabs(TimeParams->SimTime)) {
      ndbl++;
      apnd = TimeParams->SimTime;
    } else if (cdiff > 0.0) {
      apnd = (ndbl - 1.0) * TimeParams->dt;
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      n = (int32_T)ndbl;
    } else {
      n = 0;
    }

    i0 = tSAVE->size[0] * tSAVE->size[1];
    tSAVE->size[0] = 1;
    tSAVE->size[1] = n;
    emxEnsureCapacity_real_T(tSAVE, i0);
    if (n > 0) {
      tSAVE->data[0] = 0.0;
      if (n > 1) {
        tSAVE->data[n - 1] = apnd;
        nm1d2 = (n - 1) / 2;
        for (k = 0; k <= nm1d2 - 2; k++) {
          ndbl = (1.0 + (real_T)k) * TimeParams->dt;
          tSAVE->data[1 + k] = ndbl;
          tSAVE->data[(n - k) - 2] = apnd - ndbl;
        }

        if (nm1d2 << 1 == n - 1) {
          tSAVE->data[nm1d2] = apnd / 2.0;
        } else {
          ndbl = (real_T)nm1d2 * TimeParams->dt;
          tSAVE->data[nm1d2] = ndbl;
          tSAVE->data[nm1d2 + 1] = apnd - ndbl;
        }
      }
    }
  }

  emxInit_int8_T(&recordVALs, 2, true);
  i0 = recordVALs->size[0] * recordVALs->size[1];
  recordVALs->size[0] = 1;
  recordVALs->size[1] = tSAVE->size[1];
  emxEnsureCapacity_int8_T(recordVALs, i0);
  for (loopUpperBound = 0; loopUpperBound < tSAVE->size[1]; loopUpperBound++) {
    recordVALs->data[loopUpperBound] = 0;
  }

  CUDACHECK(cudaMemcpy((void *)gpu_recordIntervals, (void *)&recordIntervals[0],
                       32ULL, cudaMemcpyHostToDevice));
  CAdLIFfunction_STDP_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
    (gpu_recordIntervals, gpu_saveINT);
  CUDACHECK(cudaGetLastError());
  saveINT_dirtyOnGpu = true;
  for (ii = 0; ii < 2; ii++) {
    loopUpperBound = tSAVE->size[1];
    for (loop_ub = 0; loop_ub <= loopUpperBound - 2; loop_ub++) {
      if (saveINT_dirtyOnGpu) {
        CUDACHECK(cudaMemcpy((void *)&saveINT[0], (void *)gpu_saveINT, 32ULL,
                             cudaMemcpyDeviceToHost));
        saveINT_dirtyOnGpu = false;
      }

      if ((tSAVE->data[loop_ub] >= saveINT[ii << 1]) && (tSAVE->data[loop_ub] <=
           saveINT[1 + (ii << 1)])) {
        recordVALs->data[loop_ub] = 1;
      }
    }
  }

  emxFree_real_T(&tSAVE);

  /*  */
  /* -------------------------------------------------------------------------- */
  /* Simulation Parameters */
  EPopNum = PopParams->EPopNum;

  /* Number of excitatory neurons */
  /* Number of excitatory neurons */
  PopNum = PopParams->EPopNum + PopParams->IPopNum;

  /* Number of all neurons */
  /* Simulation Time (ms) */
  dt = TimeParams->dt;

  /* differential (ms) */
  /* Calculate time vector from time parameters */
  emxInit_real_T(&r0, 2, true);
  if (rtIsNaN(TimeParams->dt) || rtIsNaN(TimeParams->SimTime)) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[1] = 1;
    emxEnsureCapacity_real_T(r0, i0);
  } else if ((TimeParams->dt == 0.0) || ((-0.0 < TimeParams->SimTime) &&
              (TimeParams->dt < 0.0)) || ((TimeParams->SimTime < -0.0) &&
              (TimeParams->dt > 0.0))) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[1] = 0;
    emxEnsureCapacity_real_T(r0, i0);
  } else if (rtIsInf(TimeParams->SimTime) && (rtIsInf(TimeParams->dt) || (-0.0 ==
    TimeParams->SimTime))) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[1] = 1;
    emxEnsureCapacity_real_T(r0, i0);
  } else if (rtIsInf(TimeParams->dt)) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[1] = 1;
    emxEnsureCapacity_real_T(r0, i0);
  } else if (floor(TimeParams->dt) == TimeParams->dt) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[0] = 1;
    r0->size[1] = (int32_T)floor(TimeParams->SimTime / TimeParams->dt) + 1;
    emxEnsureCapacity_real_T(r0, i0);
    for (loopUpperBound = 0; loopUpperBound <= (int32_T)(TimeParams->SimTime /
          TimeParams->dt); loopUpperBound++) {
      r0->data[r0->size[0] * loopUpperBound] = TimeParams->dt * (real_T)
        loopUpperBound;
    }
  } else {
    ndbl = floor(TimeParams->SimTime / TimeParams->dt + 0.5);
    apnd = ndbl * TimeParams->dt;
    if (TimeParams->dt > 0.0) {
      cdiff = apnd - TimeParams->SimTime;
    } else {
      cdiff = TimeParams->SimTime - apnd;
    }

    if (fabs(cdiff) < 4.4408920985006262E-16 * fabs(TimeParams->SimTime)) {
      ndbl++;
      apnd = TimeParams->SimTime;
    } else if (cdiff > 0.0) {
      apnd = (ndbl - 1.0) * TimeParams->dt;
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      n = (int32_T)ndbl;
    } else {
      n = 0;
    }

    i0 = r0->size[0] * r0->size[1];
    r0->size[0] = 1;
    r0->size[1] = n;
    emxEnsureCapacity_real_T(r0, i0);
    if (n > 0) {
      r0->data[0] = -0.0;
      if (n > 1) {
        r0->data[n - 1] = apnd;
        nm1d2 = (n - 1) / 2;
        for (k = 0; k <= nm1d2 - 2; k++) {
          ndbl = (1.0 + (real_T)k) * dt;
          r0->data[1 + k] = ndbl;
          r0->data[(n - k) - 2] = apnd - ndbl;
        }

        if (nm1d2 << 1 == n - 1) {
          r0->data[nm1d2] = apnd / 2.0;
        } else {
          ndbl = (real_T)nm1d2 * TimeParams->dt;
          r0->data[nm1d2] = ndbl;
          r0->data[nm1d2 + 1] = apnd - ndbl;
        }
      }
    }
  }

  varargin_2 = r0->size[1];

  /* Time Steps (simulated) */
  emxInit_real_T(&r1, 2, true);
  if (rtIsNaN(TimeParams->SimTime)) {
    i0 = r1->size[0] * r1->size[1];
    r1->size[1] = 1;
    emxEnsureCapacity_real_T(r1, i0);
  } else if (TimeParams->SimTime < 0.0) {
    i0 = r1->size[0] * r1->size[1];
    r1->size[1] = 0;
    emxEnsureCapacity_real_T(r1, i0);
  } else if (rtIsInf(TimeParams->SimTime) && (0.0 == TimeParams->SimTime)) {
    i0 = r1->size[0] * r1->size[1];
    r1->size[1] = 1;
    emxEnsureCapacity_real_T(r1, i0);
  } else {
    i0 = r1->size[0] * r1->size[1];
    r1->size[0] = 1;
    r1->size[1] = (int32_T)floor(TimeParams->SimTime) + 1;
    emxEnsureCapacity_real_T(r1, i0);
    for (loopUpperBound = 0; loopUpperBound <= (int32_T)TimeParams->SimTime;
         loopUpperBound++) {
      r1->data[r1->size[0] * loopUpperBound] = loopUpperBound;
    }
  }

  /* Time Steps (saved) */
  emxInit_real_T(&r2, 2, true);
  if (rtIsNaN(TimeParams->SimTime)) {
    i0 = r2->size[0] * r2->size[1];
    r2->size[1] = 1;
    emxEnsureCapacity_real_T(r2, i0);
  } else if (TimeParams->SimTime < 0.0) {
    i0 = r2->size[0] * r2->size[1];
    r2->size[1] = 0;
    emxEnsureCapacity_real_T(r2, i0);
  } else if (rtIsInf(TimeParams->SimTime) && (0.0 == TimeParams->SimTime)) {
    i0 = r2->size[0] * r2->size[1];
    r2->size[1] = 1;
    emxEnsureCapacity_real_T(r2, i0);
  } else {
    i0 = r2->size[0] * r2->size[1];
    r2->size[0] = 1;
    r2->size[1] = (int32_T)floor(TimeParams->SimTime / 10.0) + 1;
    emxEnsureCapacity_real_T(r2, i0);
    for (loopUpperBound = 0; loopUpperBound <= (int32_T)(TimeParams->SimTime /
          10.0); loopUpperBound++) {
      r2->data[r2->size[0] * loopUpperBound] = 10.0 * (real_T)loopUpperBound;
    }
  }

  emxInit_real_T(&EE_mat, 2, true);

  /* Time Steps (saved) */
  /* -------------------------------------------------------------------------- */
  /* Weight Matrices */
  i0 = EE_mat->size[0] * EE_mat->size[1];
  EE_mat->size[0] = (int32_T)PopNum;
  EE_mat->size[1] = (int32_T)PopNum;
  emxEnsureCapacity_real_T(EE_mat, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum * (int32_T)PopNum;
       loopUpperBound++) {
    EE_mat->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T(&II_mat, 2, true);
  i0 = II_mat->size[0] * II_mat->size[1];
  II_mat->size[0] = (int32_T)PopNum;
  II_mat->size[1] = (int32_T)PopNum;
  emxEnsureCapacity_real_T(II_mat, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum * (int32_T)PopNum;
       loopUpperBound++) {
    II_mat->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T(&IE_mat, 2, true);
  i0 = IE_mat->size[0] * IE_mat->size[1];
  IE_mat->size[0] = (int32_T)PopNum;
  IE_mat->size[1] = (int32_T)PopNum;
  emxEnsureCapacity_real_T(IE_mat, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum * (int32_T)PopNum;
       loopUpperBound++) {
    IE_mat->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T(&EI_mat, 2, true);
  i0 = EI_mat->size[0] * EI_mat->size[1];
  EI_mat->size[0] = (int32_T)PopNum;
  EI_mat->size[1] = (int32_T)PopNum;
  emxEnsureCapacity_real_T(EI_mat, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum * (int32_T)PopNum;
       loopUpperBound++) {
    EI_mat->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T(&Ecells, 2, true);
  if (rtIsNaN(PopParams->EPopNum)) {
    i0 = Ecells->size[0] * Ecells->size[1];
    Ecells->size[0] = 1;
    Ecells->size[1] = 1;
    emxEnsureCapacity_real_T(Ecells, i0);
    Ecells->data[0] = rtNaN;
  } else if (PopParams->EPopNum < 1.0) {
    i0 = Ecells->size[0] * Ecells->size[1];
    Ecells->size[0] = 1;
    Ecells->size[1] = 0;
    emxEnsureCapacity_real_T(Ecells, i0);
  } else if (rtIsInf(PopParams->EPopNum) && (1.0 == PopParams->EPopNum)) {
    i0 = Ecells->size[0] * Ecells->size[1];
    Ecells->size[0] = 1;
    Ecells->size[1] = 1;
    emxEnsureCapacity_real_T(Ecells, i0);
    Ecells->data[0] = rtNaN;
  } else {
    i0 = Ecells->size[0] * Ecells->size[1];
    Ecells->size[0] = 1;
    Ecells->size[1] = (int32_T)floor(PopParams->EPopNum - 1.0) + 1;
    emxEnsureCapacity_real_T(Ecells, i0);
    for (loopUpperBound = 0; loopUpperBound <= (int32_T)(PopParams->EPopNum -
          1.0); loopUpperBound++) {
      Ecells->data[Ecells->size[0] * loopUpperBound] = 1.0 + (real_T)
        loopUpperBound;
    }
  }

  emxInit_real_T(&y, 2, true);
  if (PopNum < 1.0) {
    i0 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = 0;
    emxEnsureCapacity_real_T(y, i0);
  } else if (rtIsInf(PopNum) && (1.0 == PopNum)) {
    i0 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = 1;
    emxEnsureCapacity_real_T(y, i0);
    y->data[0] = rtNaN;
  } else {
    i0 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = (int32_T)floor(PopNum - 1.0) + 1;
    emxEnsureCapacity_real_T(y, i0);
    for (loopUpperBound = 0; loopUpperBound <= (int32_T)(PopNum - 1.0);
         loopUpperBound++) {
      y->data[y->size[0] * loopUpperBound] = 1.0 + (real_T)loopUpperBound;
    }
  }

  emxInit_boolean_T(&EcellIDX, 2, true);
  i0 = EcellIDX->size[0] * EcellIDX->size[1];
  EcellIDX->size[0] = 1;
  EcellIDX->size[1] = y->size[1];
  emxEnsureCapacity_boolean_T(EcellIDX, i0);
  for (loopUpperBound = 0; loopUpperBound < y->size[0] * y->size[1];
       loopUpperBound++) {
    EcellIDX->data[loopUpperBound] = (y->data[loopUpperBound] <=
      PopParams->EPopNum);
  }

  emxFree_real_T(&y);

  /* EcellIDX = ismember(1:PopNum,Ecells); */
  emxInit_real_T(&Icells, 2, true);
  if (rtIsNaN(PopParams->EPopNum + 1.0)) {
    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = 1;
    emxEnsureCapacity_real_T(Icells, i0);
    Icells->data[0] = rtNaN;
  } else if (PopNum < PopParams->EPopNum + 1.0) {
    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = 0;
    emxEnsureCapacity_real_T(Icells, i0);
  } else if ((rtIsInf(PopParams->EPopNum + 1.0) || rtIsInf(PopNum)) &&
             (PopParams->EPopNum + 1.0 == PopNum)) {
    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = 1;
    emxEnsureCapacity_real_T(Icells, i0);
    Icells->data[0] = rtNaN;
  } else if (floor(PopParams->EPopNum + 1.0) == PopParams->EPopNum + 1.0) {
    ndbl = PopParams->EPopNum + 1.0;
    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = (int32_T)floor(PopNum - (PopParams->EPopNum + 1.0)) + 1;
    emxEnsureCapacity_real_T(Icells, i0);
    for (loopUpperBound = 0; loopUpperBound <= (int32_T)(PopNum - ndbl);
         loopUpperBound++) {
      Icells->data[Icells->size[0] * loopUpperBound] = ndbl + (real_T)
        loopUpperBound;
    }
  } else {
    ndbl = floor((PopNum - (PopParams->EPopNum + 1.0)) + 0.5);
    apnd = (PopParams->EPopNum + 1.0) + ndbl;
    cdiff = apnd - PopNum;
    absa = fabs(PopParams->EPopNum + 1.0);
    if (!((absa > PopNum) || rtIsNaN(PopNum))) {
      absa = PopNum;
    }

    if (fabs(cdiff) < 4.4408920985006262E-16 * absa) {
      ndbl++;
      apnd = PopNum;
    } else if (cdiff > 0.0) {
      apnd = (PopParams->EPopNum + 1.0) + (ndbl - 1.0);
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      n = (int32_T)ndbl;
    } else {
      n = 0;
    }

    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = n;
    emxEnsureCapacity_real_T(Icells, i0);
    if (n > 0) {
      Icells->data[0] = PopParams->EPopNum + 1.0;
      if (n > 1) {
        Icells->data[n - 1] = apnd;
        nm1d2 = (n - 1) / 2;
        for (k = 0; k <= nm1d2 - 2; k++) {
          Icells->data[1 + k] = (EPopNum + 1.0) + (1.0 + (real_T)k);
          Icells->data[(n - k) - 2] = apnd - (1.0 + (real_T)k);
        }

        if (nm1d2 << 1 == n - 1) {
          Icells->data[nm1d2] = ((PopParams->EPopNum + 1.0) + apnd) / 2.0;
        } else {
          Icells->data[nm1d2] = (PopParams->EPopNum + 1.0) + (real_T)nm1d2;
          Icells->data[nm1d2 + 1] = apnd - (real_T)nm1d2;
        }
      }
    }
  }

  emxInit_real_T(&b_y, 2, true);
  if (PopNum < 1.0) {
    i0 = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 1;
    b_y->size[1] = 0;
    emxEnsureCapacity_real_T(b_y, i0);
  } else if (rtIsInf(PopNum) && (1.0 == PopNum)) {
    i0 = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 1;
    b_y->size[1] = 1;
    emxEnsureCapacity_real_T(b_y, i0);
    b_y->data[0] = rtNaN;
  } else {
    i0 = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 1;
    b_y->size[1] = (int32_T)floor(PopNum - 1.0) + 1;
    emxEnsureCapacity_real_T(b_y, i0);
    for (loopUpperBound = 0; loopUpperBound <= (int32_T)(PopNum - 1.0);
         loopUpperBound++) {
      b_y->data[b_y->size[0] * loopUpperBound] = 1.0 + (real_T)loopUpperBound;
    }
  }

  emxInit_boolean_T(&IcellIDX, 2, true);
  i0 = IcellIDX->size[0] * IcellIDX->size[1];
  IcellIDX->size[0] = 1;
  IcellIDX->size[1] = b_y->size[1];
  emxEnsureCapacity_boolean_T(IcellIDX, i0);
  for (loopUpperBound = 0; loopUpperBound < b_y->size[0] * b_y->size[1];
       loopUpperBound++) {
    IcellIDX->data[loopUpperBound] = (b_y->data[loopUpperBound] >
      PopParams->EPopNum);
  }

  emxFree_real_T(&b_y);
  emxInit_int32_T(&r3, 1, true);

  /* IcellIDX = ismember(1:PopNum,Icells); */
  /* Here we assign four 2x2 matrices of matrix (tensor?). There are positive values on the locations where there are connections. */
  /* For example, there are values for the EE connections on the 1x1 matrix, II */
  /* on the 2x2 matrix, and etc (this is based on the indexing of the neuron population).  */
  /* NOTE: presynaptic neurons are columns (dim2) and postsynaptic neurons are rows (dim1). */
  /* E->E Synapses */
  ndbl = PopParams->Kee / (PopParams->EPopNum - 1.0);

  /* -1 to account for self-connections (which are then removed) */
  i0 = r3->size[0];
  r3->size[0] = Ecells->size[1];
  emxEnsureCapacity_int32_T(r3, i0);
  for (loopUpperBound = 0; loopUpperBound < Ecells->size[1]; loopUpperBound++) {
    r3->data[loopUpperBound] = (int32_T)Ecells->data[Ecells->size[0] *
      loopUpperBound] - 1;
  }

  emxInit_int32_T(&r4, 1, true);
  i0 = r4->size[0];
  r4->size[0] = Ecells->size[1];
  emxEnsureCapacity_int32_T(r4, i0);
  for (loopUpperBound = 0; loopUpperBound < Ecells->size[1]; loopUpperBound++) {
    r4->data[loopUpperBound] = (int32_T)Ecells->data[Ecells->size[0] *
      loopUpperBound] - 1;
  }

  emxInit_real_T(&r, 2, true);
  i0 = r->size[0] * r->size[1];
  r->size[0] = (int32_T)PopParams->EPopNum;
  r->size[1] = (int32_T)PopParams->EPopNum;
  emxEnsureCapacity_real_T(r, i0);
  if (!((r->size[0] == 0) || (r->size[1] == 0))) {
    emlrtRandu(&r->data[0], r->size[0] * r->size[1]);
  }

  for (i0 = 0; i0 < r->size[1]; i0++) {
    for (loopUpperBound = 0; loopUpperBound < r->size[0]; loopUpperBound++) {
      EE_mat->data[r3->data[loopUpperBound] + EE_mat->size[0] * r4->data[i0]] =
        (r->data[loopUpperBound + r->size[0] * i0] <= ndbl);
    }
  }

  emxFree_real_T(&r);
  emxFree_int32_T(&r4);
  emxFree_int32_T(&r3);
  i0 = EE_mat->size[0] * EE_mat->size[1];
  nm1d2 = EE_mat->size[0] * EE_mat->size[1];
  emxEnsureCapacity_real_T(EE_mat, nm1d2);
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    EE_mat->data[loopUpperBound] *= PopParams->Wee;
  }

  for (loopUpperBound = 0; loopUpperBound < 2; loopUpperBound++) {
    uv0[loopUpperBound] = (uint32_T)EE_mat->size[loopUpperBound];
  }

  emxInit_boolean_T1(&d, 1, true);
  if (((int32_T)uv0[0] == 1) && ((int32_T)uv0[1] == 1)) {
    i0 = d->size[0];
    d->size[0] = 1;
    emxEnsureCapacity_boolean_T1(d, i0);
  } else {
    if (0 < (int32_T)uv0[1]) {
      if ((int32_T)uv0[0] < (int32_T)uv0[1]) {
        nm1d2 = (int32_T)uv0[0];
      } else {
        nm1d2 = (int32_T)uv0[1];
      }
    } else {
      nm1d2 = 0;
    }

    i0 = d->size[0];
    d->size[0] = nm1d2;
    emxEnsureCapacity_boolean_T1(d, i0);
    for (ii = 0; ii < nm1d2; ii++) {
      d->data[ii] = true;
    }
  }

  emxInit_boolean_T(&r5, 2, true);
  iv0[0] = d->size[0];
  iv0[1] = d->size[0];
  i0 = r5->size[0] * r5->size[1];
  r5->size[0] = iv0[0];
  r5->size[1] = iv0[1];
  emxEnsureCapacity_boolean_T(r5, i0);
  for (loopUpperBound = 0; loopUpperBound < iv0[0] * iv0[1]; loopUpperBound++) {
    r5->data[loopUpperBound] = false;
  }

  b_loopUpperBound = d->size[0];
  emxFree_boolean_T(&d);
  for (ii = 0; ii < b_loopUpperBound; ii++) {
    r5->data[ii + r5->size[0] * ii] = true;
  }

  n = r5->size[0] * r5->size[1] - 1;
  nm1d2 = 0;
  for (mA = 0; mA <= n; mA++) {
    if (r5->data[mA]) {
      nm1d2++;
    }
  }

  emxInit_int32_T(&r6, 1, true);
  i0 = r6->size[0];
  r6->size[0] = nm1d2;
  emxEnsureCapacity_int32_T(r6, i0);
  nm1d2 = 0;
  for (mA = 0; mA <= n; mA++) {
    if (r5->data[mA]) {
      r6->data[nm1d2] = mA + 1;
      nm1d2++;
    }
  }

  emxFree_boolean_T(&r5);
  i0 = r6->size[0];
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    EE_mat->data[r6->data[loopUpperBound] - 1] = 0.0;
  }

  emxFree_int32_T(&r6);
  emxInit_int32_T(&r7, 1, true);

  /* Remove selfconnections */
  /* I->I Synapses */
  ndbl = PopParams->Kii / (PopParams->IPopNum - 1.0);
  i0 = r7->size[0];
  r7->size[0] = Icells->size[1];
  emxEnsureCapacity_int32_T(r7, i0);
  for (loopUpperBound = 0; loopUpperBound < Icells->size[1]; loopUpperBound++) {
    r7->data[loopUpperBound] = (int32_T)Icells->data[Icells->size[0] *
      loopUpperBound] - 1;
  }

  emxInit_int32_T(&r8, 1, true);
  i0 = r8->size[0];
  r8->size[0] = Icells->size[1];
  emxEnsureCapacity_int32_T(r8, i0);
  for (loopUpperBound = 0; loopUpperBound < Icells->size[1]; loopUpperBound++) {
    r8->data[loopUpperBound] = (int32_T)Icells->data[Icells->size[0] *
      loopUpperBound] - 1;
  }

  emxInit_real_T(&b_r, 2, true);
  i0 = b_r->size[0] * b_r->size[1];
  b_r->size[0] = (int32_T)PopParams->IPopNum;
  b_r->size[1] = (int32_T)PopParams->IPopNum;
  emxEnsureCapacity_real_T(b_r, i0);
  if (!((b_r->size[0] == 0) || (b_r->size[1] == 0))) {
    emlrtRandu(&b_r->data[0], b_r->size[0] * b_r->size[1]);
  }

  for (i0 = 0; i0 < b_r->size[1]; i0++) {
    for (loopUpperBound = 0; loopUpperBound < b_r->size[0]; loopUpperBound++) {
      II_mat->data[r7->data[loopUpperBound] + II_mat->size[0] * r8->data[i0]] =
        (b_r->data[loopUpperBound + b_r->size[0] * i0] <= ndbl);
    }
  }

  emxFree_real_T(&b_r);
  emxFree_int32_T(&r8);
  emxFree_int32_T(&r7);
  i0 = II_mat->size[0] * II_mat->size[1];
  nm1d2 = II_mat->size[0] * II_mat->size[1];
  emxEnsureCapacity_real_T(II_mat, nm1d2);
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    II_mat->data[loopUpperBound] *= PopParams->Wii;
  }

  for (loopUpperBound = 0; loopUpperBound < 2; loopUpperBound++) {
    uv0[loopUpperBound] = (uint32_T)II_mat->size[loopUpperBound];
  }

  emxInit_boolean_T1(&b_d, 1, true);
  if (((int32_T)uv0[0] == 1) && ((int32_T)uv0[1] == 1)) {
    i0 = b_d->size[0];
    b_d->size[0] = 1;
    emxEnsureCapacity_boolean_T1(b_d, i0);
  } else {
    if (0 < (int32_T)uv0[1]) {
      if ((int32_T)uv0[0] < (int32_T)uv0[1]) {
        nm1d2 = (int32_T)uv0[0];
      } else {
        nm1d2 = (int32_T)uv0[1];
      }
    } else {
      nm1d2 = 0;
    }

    i0 = b_d->size[0];
    b_d->size[0] = nm1d2;
    emxEnsureCapacity_boolean_T1(b_d, i0);
    for (ii = 0; ii < nm1d2; ii++) {
      b_d->data[ii] = true;
    }
  }

  emxInit_boolean_T(&r9, 2, true);
  iv0[0] = b_d->size[0];
  iv0[1] = b_d->size[0];
  i0 = r9->size[0] * r9->size[1];
  r9->size[0] = iv0[0];
  r9->size[1] = iv0[1];
  emxEnsureCapacity_boolean_T(r9, i0);
  for (loopUpperBound = 0; loopUpperBound < iv0[0] * iv0[1]; loopUpperBound++) {
    r9->data[loopUpperBound] = false;
  }

  b_loopUpperBound = b_d->size[0];
  emxFree_boolean_T(&b_d);
  for (ii = 0; ii < b_loopUpperBound; ii++) {
    r9->data[ii + r9->size[0] * ii] = true;
  }

  n = r9->size[0] * r9->size[1] - 1;
  nm1d2 = 0;
  for (mA = 0; mA <= n; mA++) {
    if (r9->data[mA]) {
      nm1d2++;
    }
  }

  emxInit_int32_T(&r10, 1, true);
  i0 = r10->size[0];
  r10->size[0] = nm1d2;
  emxEnsureCapacity_int32_T(r10, i0);
  nm1d2 = 0;
  for (mA = 0; mA <= n; mA++) {
    if (r9->data[mA]) {
      r10->data[nm1d2] = mA + 1;
      nm1d2++;
    }
  }

  emxFree_boolean_T(&r9);
  i0 = r10->size[0];
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    II_mat->data[r10->data[loopUpperBound] - 1] = 0.0;
  }

  emxFree_int32_T(&r10);
  emxInit_int32_T(&r11, 1, true);

  /* Remove selfconnections */
  /* E->I Synapses */
  ndbl = PopParams->Kie / PopParams->EPopNum;
  i0 = r11->size[0];
  r11->size[0] = Icells->size[1];
  emxEnsureCapacity_int32_T(r11, i0);
  for (loopUpperBound = 0; loopUpperBound < Icells->size[1]; loopUpperBound++) {
    r11->data[loopUpperBound] = (int32_T)Icells->data[Icells->size[0] *
      loopUpperBound] - 1;
  }

  emxInit_int32_T(&r12, 1, true);
  i0 = r12->size[0];
  r12->size[0] = Ecells->size[1];
  emxEnsureCapacity_int32_T(r12, i0);
  for (loopUpperBound = 0; loopUpperBound < Ecells->size[1]; loopUpperBound++) {
    r12->data[loopUpperBound] = (int32_T)Ecells->data[Ecells->size[0] *
      loopUpperBound] - 1;
  }

  emxInit_real_T(&c_r, 2, true);
  i0 = c_r->size[0] * c_r->size[1];
  c_r->size[0] = (int32_T)PopParams->IPopNum;
  c_r->size[1] = (int32_T)PopParams->EPopNum;
  emxEnsureCapacity_real_T(c_r, i0);
  if (!((c_r->size[0] == 0) || (c_r->size[1] == 0))) {
    emlrtRandu(&c_r->data[0], c_r->size[0] * c_r->size[1]);
  }

  for (i0 = 0; i0 < c_r->size[1]; i0++) {
    for (loopUpperBound = 0; loopUpperBound < c_r->size[0]; loopUpperBound++) {
      IE_mat->data[r11->data[loopUpperBound] + IE_mat->size[0] * r12->data[i0]] =
        (c_r->data[loopUpperBound + c_r->size[0] * i0] <= ndbl);
    }
  }

  emxFree_real_T(&c_r);
  emxFree_int32_T(&r12);
  emxFree_int32_T(&r11);
  i0 = IE_mat->size[0] * IE_mat->size[1];
  nm1d2 = IE_mat->size[0] * IE_mat->size[1];
  emxEnsureCapacity_real_T(IE_mat, nm1d2);
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    IE_mat->data[loopUpperBound] *= PopParams->Wie;
  }

  emxInit_int32_T(&r13, 1, true);

  /* I->E Synapses */
  ndbl = PopParams->Kei / PopParams->IPopNum;
  i0 = r13->size[0];
  r13->size[0] = Ecells->size[1];
  emxEnsureCapacity_int32_T(r13, i0);
  for (loopUpperBound = 0; loopUpperBound < Ecells->size[1]; loopUpperBound++) {
    r13->data[loopUpperBound] = (int32_T)Ecells->data[Ecells->size[0] *
      loopUpperBound] - 1;
  }

  emxInit_int32_T(&r14, 1, true);
  i0 = r14->size[0];
  r14->size[0] = Icells->size[1];
  emxEnsureCapacity_int32_T(r14, i0);
  for (loopUpperBound = 0; loopUpperBound < Icells->size[1]; loopUpperBound++) {
    r14->data[loopUpperBound] = (int32_T)Icells->data[Icells->size[0] *
      loopUpperBound] - 1;
  }

  emxInit_real_T(&d_r, 2, true);
  i0 = d_r->size[0] * d_r->size[1];
  d_r->size[0] = (int32_T)PopParams->EPopNum;
  d_r->size[1] = (int32_T)PopParams->IPopNum;
  emxEnsureCapacity_real_T(d_r, i0);
  if (!((d_r->size[0] == 0) || (d_r->size[1] == 0))) {
    emlrtRandu(&d_r->data[0], d_r->size[0] * d_r->size[1]);
  }

  for (i0 = 0; i0 < d_r->size[1]; i0++) {
    for (loopUpperBound = 0; loopUpperBound < d_r->size[0]; loopUpperBound++) {
      EI_mat->data[r13->data[loopUpperBound] + EI_mat->size[0] * r14->data[i0]] =
        (d_r->data[loopUpperBound + d_r->size[0] * i0] <= ndbl);
    }
  }

  emxFree_real_T(&d_r);
  emxFree_int32_T(&r14);
  emxFree_int32_T(&r13);
  i0 = EI_mat->size[0] * EI_mat->size[1];
  nm1d2 = EI_mat->size[0] * EI_mat->size[1];
  emxEnsureCapacity_real_T(EI_mat, nm1d2);
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    EI_mat->data[loopUpperBound] *= PopParams->Wei;
  }

  emxInit_boolean_T(&isconnected, 2, true);
  i0 = isconnected->size[0] * isconnected->size[1];
  isconnected->size[0] = EE_mat->size[0];
  isconnected->size[1] = EE_mat->size[1];
  emxEnsureCapacity_boolean_T(isconnected, i0);
  for (loopUpperBound = 0; loopUpperBound < EE_mat->size[0] * EE_mat->size[1];
       loopUpperBound++) {
    isconnected->data[loopUpperBound] = (((EE_mat->data[loopUpperBound] +
      II_mat->data[loopUpperBound]) + EI_mat->data[loopUpperBound]) +
      IE_mat->data[loopUpperBound] > 0.0);
  }

  emxInit_real_T1(&E_L, 1, true);

  /*  */
  /* -------------------------------------------------------------------------- */
  /* Simulation Parameters */
  /* LIF Parameters */
  /*  E_L         = PopParams.E_L;      %Reversal potential (mV) */
  /*  g_L         = PopParams.g_L;     %conductance (units?) */
  /*  C           = PopParams.C;       %capacitance (nF) */
  /*  I_e         = PopParams.I_e;      %current (nA) */
  /*  V_th        = PopParams.V_th;    %spike threshhold (mV) */
  /*  V_reset     = PopParams.V_reset; %reset value (mV) */
  /*   */
  /*  t_ref       = PopParams.t_ref;   %refractory period (ms) */
  /*   */
  /*  sigma       = PopParams.sigma;   %Standard deviation of noise */
  /*  theta       = PopParams.theta;   %Strength to mean (time scale of noise, ms^-1) */
  /*   */
  /*  %-------------------------------------------------------------------------- */
  /*  %Adaptation */
  /*  E_w         = PopParams.E_w;     %Adaptation reversal potential, (mV) */
  /*  b_w         = PopParams.b_w;     %Adaptation decay (1/ms) */
  /*   */
  /*  delta_T     = PopParams.delta_T; %threshhold softness */
  /*   */
  /*  gwnorm      = PopParams.gwnorm;  %Adaptation norm (nS) */
  /*  w_r         = PopParams.w_r;     %Adaptation at rest (E_L) */
  /*   */
  /*  b           = PopParams.b;       %Spike Adaptation (nS) */
  /*   */
  /*  %-------------------------------------------------------------------------- */
  /*  % Synapse Parameters */
  /*  E_e         = PopParams.E_e;     %Excitatory reversal potential (mV) */
  /*  E_i         = PopParams.E_i;     %Inhibitory reversal potential (mV) */
  /*   */
  /*  tau_s       = PopParams.tau_s;     %Synaptic decay (ms) */
  /*   */
  /*  %STDP parameters */
  /*  LearningRate = PopParams.LearningRate; */
  /*  TargetRate   = PopParams.TargetRate; %Target Rate for Excitatory cells (units of Hz) */
  /*  tauSTDP      = PopParams.tauSTDP;    %Time Constant for the STDP curve (Units of ms) */
  /*  alpha = 2.*(PopParams.TargetRate./1000).*tauSTDP; %Alpha parameter from Vogels eqn5 */
  /* Note target rate is converted to spks/ms */
  i0 = E_L->size[0];
  E_L->size[0] = (int32_T)PopParams->EPopNum + (int32_T)PopParams->IPopNum;
  emxEnsureCapacity_real_T1(E_L, i0);
  nm1d2 = (int32_T)PopParams->EPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    E_L->data[loopUpperBound] = PopParams->E_L[0];
  }

  nm1d2 = (int32_T)PopParams->IPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    E_L->data[loopUpperBound + (int32_T)PopParams->EPopNum] = PopParams->E_L[1];
  }

  emxInit_real_T1(&g_L, 1, true);
  i0 = g_L->size[0];
  g_L->size[0] = (int32_T)PopParams->EPopNum + (int32_T)PopParams->IPopNum;
  emxEnsureCapacity_real_T1(g_L, i0);
  nm1d2 = (int32_T)PopParams->EPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    g_L->data[loopUpperBound] = PopParams->g_L[0];
  }

  nm1d2 = (int32_T)PopParams->IPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    g_L->data[loopUpperBound + (int32_T)PopParams->EPopNum] = PopParams->g_L[1];
  }

  emxInit_real_T1(&C, 1, true);
  i0 = C->size[0];
  C->size[0] = (int32_T)PopParams->EPopNum + (int32_T)PopParams->IPopNum;
  emxEnsureCapacity_real_T1(C, i0);
  nm1d2 = (int32_T)PopParams->EPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    C->data[loopUpperBound] = PopParams->C[0];
  }

  nm1d2 = (int32_T)PopParams->IPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    C->data[loopUpperBound + (int32_T)PopParams->EPopNum] = PopParams->C[1];
  }

  emxInit_real_T1(&I_e, 1, true);
  i0 = I_e->size[0];
  I_e->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(I_e, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    I_e->data[loopUpperBound] = PopParams->I_e;
  }

  emxInit_real_T1(&V_th, 1, true);
  i0 = V_th->size[0];
  V_th->size[0] = (int32_T)PopParams->EPopNum + (int32_T)PopParams->IPopNum;
  emxEnsureCapacity_real_T1(V_th, i0);
  nm1d2 = (int32_T)PopParams->EPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    V_th->data[loopUpperBound] = PopParams->V_th[0];
  }

  nm1d2 = (int32_T)PopParams->IPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    V_th->data[loopUpperBound + (int32_T)PopParams->EPopNum] = PopParams->V_th[1];
  }

  emxInit_real_T1(&V_reset, 1, true);
  i0 = V_reset->size[0];
  V_reset->size[0] = (int32_T)PopParams->EPopNum + (int32_T)PopParams->IPopNum;
  emxEnsureCapacity_real_T1(V_reset, i0);
  nm1d2 = (int32_T)PopParams->EPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    V_reset->data[loopUpperBound] = PopParams->V_reset[0];
  }

  nm1d2 = (int32_T)PopParams->IPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    V_reset->data[loopUpperBound + (int32_T)PopParams->EPopNum] =
      PopParams->V_reset[1];
  }

  emxInit_real_T1(&t_ref, 1, true);
  i0 = t_ref->size[0];
  t_ref->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(t_ref, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    t_ref->data[loopUpperBound] = PopParams->t_ref;
  }

  emxInit_real_T1(&sigma, 1, true);
  i0 = sigma->size[0];
  sigma->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sigma, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    sigma->data[loopUpperBound] = PopParams->sigma;
  }

  emxInit_real_T1(&theta, 1, true);
  i0 = theta->size[0];
  theta->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(theta, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    theta->data[loopUpperBound] = PopParams->theta;
  }

  emxInit_real_T1(&E_w, 1, true);
  i0 = E_w->size[0];
  E_w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(E_w, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    E_w->data[loopUpperBound] = PopParams->E_w;
  }

  emxInit_real_T1(&b_w, 1, true);
  i0 = b_w->size[0];
  b_w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(b_w, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    b_w->data[loopUpperBound] = PopParams->b_w;
  }

  emxInit_real_T1(&delta_T, 1, true);
  i0 = delta_T->size[0];
  delta_T->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(delta_T, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    delta_T->data[loopUpperBound] = PopParams->delta_T;
  }

  emxInit_real_T1(&gwnorm, 1, true);
  i0 = gwnorm->size[0];
  gwnorm->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(gwnorm, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    gwnorm->data[loopUpperBound] = PopParams->gwnorm;
  }

  emxInit_real_T1(&w_r, 1, true);
  i0 = w_r->size[0];
  w_r->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(w_r, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    w_r->data[loopUpperBound] = PopParams->w_r;
  }

  emxInit_real_T1(&b, 1, true);
  i0 = b->size[0];
  b->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(b, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    b->data[loopUpperBound] = PopParams->b;
  }

  emxInit_real_T1(&E_e, 1, true);
  i0 = E_e->size[0];
  E_e->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(E_e, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    E_e->data[loopUpperBound] = PopParams->E_e;
  }

  emxInit_real_T1(&E_i, 1, true);
  i0 = E_i->size[0];
  E_i->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(E_i, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    E_i->data[loopUpperBound] = PopParams->E_i;
  }

  emxInit_real_T1(&tau_s, 1, true);
  i0 = tau_s->size[0];
  tau_s->size[0] = (int32_T)PopParams->EPopNum + (int32_T)PopParams->IPopNum;
  emxEnsureCapacity_real_T1(tau_s, i0);
  nm1d2 = (int32_T)PopParams->EPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    tau_s->data[loopUpperBound] = PopParams->tau_s[0];
  }

  nm1d2 = (int32_T)PopParams->IPopNum - 1;
  for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
    tau_s->data[loopUpperBound + (int32_T)PopParams->EPopNum] = PopParams->
      tau_s[1];
  }

  emxInit_real_T1(&ELearningRate, 1, true);
  i0 = ELearningRate->size[0];
  ELearningRate->size[0] = (int32_T)PopParams->EPopNum;
  emxEnsureCapacity_real_T1(ELearningRate, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopParams->EPopNum;
       loopUpperBound++) {
    ELearningRate->data[loopUpperBound] = PopParams->LearningRate;
  }

  emxInit_real_T(&ILearningRate, 2, true);
  i0 = ILearningRate->size[0] * ILearningRate->size[1];
  ILearningRate->size[0] = 1;
  ILearningRate->size[1] = (int32_T)PopParams->IPopNum;
  emxEnsureCapacity_real_T(ILearningRate, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopParams->IPopNum;
       loopUpperBound++) {
    ILearningRate->data[loopUpperBound] = PopParams->LearningRate;
  }

  emxInit_real_T1(&tauSTDP, 1, true);

  /* Target Rate for Excitatory cells (units of Hz) */
  i0 = tauSTDP->size[0];
  tauSTDP->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(tauSTDP, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    tauSTDP->data[loopUpperBound] = PopParams->tauSTDP;
  }

  emxInit_real_T1(&alpha, 1, true);

  /* Time Constant for the STDP curve (Units of ms) */
  ndbl = 2.0 * (PopParams->TargetRate / 1000.0) * PopParams->tauSTDP;
  i0 = alpha->size[0];
  alpha->size[0] = (int32_T)PopParams->EPopNum;
  emxEnsureCapacity_real_T1(alpha, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopParams->EPopNum;
       loopUpperBound++) {
    alpha->data[loopUpperBound] = ndbl;
  }

  emxInit_real_T1(&V, 1, true);

  /* Alpha parameter from Vogels eqn5 */
  /*  Input: convert into function of t */
  /*  if isa(I_e, 'function_handle') */
  /*  elseif isequal(size(I_e),[1 1]) */
  /*      I_e = @(t) I_e; */
  /*  elseif length(I_e) == 2 */
  /*      I_e = @(t) transpose([I_e(1).*ones(1,EPopNum),     I_e(2).*ones(1,IPopNum)]); */
  /*  end */
  /*  Variables */
  /* Simulation Variables */
  i0 = V->size[0];
  V->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(V, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    V->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T1(&g_e, 1, true);

  /* Membrane Potential */
  i0 = g_e->size[0];
  g_e->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(g_e, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    g_e->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T1(&g_i, 1, true);

  /* conductance of synapse  */
  i0 = g_i->size[0];
  g_i->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(g_i, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    g_i->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T1(&g_w, 1, true);

  /* conductance of synapse  */
  i0 = g_w->size[0];
  g_w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(g_w, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    g_w->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T1(&a_w, 1, true);

  /* conductance of adaptation  */
  i0 = a_w->size[0];
  a_w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(a_w, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    a_w->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T1(&s, 1, true);

  /* adaptation rise (1/ms) */
  i0 = s->size[0];
  s->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(s, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    s->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T1(&w, 1, true);

  /* synapse  */
  i0 = w->size[0];
  w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(w, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    w->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T1(&X_t, 1, true);

  /* adaptation */
  i0 = X_t->size[0];
  X_t->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(X_t, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    X_t->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T1(&t_r, 1, true);

  /* OU noise */
  i0 = t_r->size[0];
  t_r->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(t_r, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    t_r->data[loopUpperBound] = 0.0;
  }

  emxInit_real_T1(&x, 1, true);
  i0 = x->size[0];
  x->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(x, i0);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)PopNum; loopUpperBound++) {
    x->data[loopUpperBound] = 0.0;
  }

  /* Synaptic trace */
  /* Saved Variables */
  i0 = SimValues->t->size[0] * SimValues->t->size[1];
  SimValues->t->size[0] = 1;
  SimValues->t->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(SimValues->t, i0);
  for (i0 = 0; i0 < r1->size[1]; i0++) {
    SimValues->t->data[i0] = rtNaN;
  }

  i0 = SimValues->V->size[0] * SimValues->V->size[1];
  SimValues->V->size[0] = (int32_T)PopNum;
  SimValues->V->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(SimValues->V, i0);
  for (i0 = 0; i0 < (int32_T)PopNum * r1->size[1]; i0++) {
    SimValues->V->data[i0] = rtNaN;
  }

  i0 = SimValues->g_w->size[0] * SimValues->g_w->size[1];
  SimValues->g_w->size[0] = (int32_T)PopNum;
  SimValues->g_w->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(SimValues->g_w, i0);
  for (i0 = 0; i0 < (int32_T)PopNum * r1->size[1]; i0++) {
    SimValues->g_w->data[i0] = rtNaN;
  }

  i0 = SimValues->g_e->size[0] * SimValues->g_e->size[1];
  SimValues->g_e->size[0] = (int32_T)PopNum;
  SimValues->g_e->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(SimValues->g_e, i0);
  for (i0 = 0; i0 < (int32_T)PopNum * r1->size[1]; i0++) {
    SimValues->g_e->data[i0] = rtNaN;
  }

  i0 = SimValues->g_i->size[0] * SimValues->g_i->size[1];
  SimValues->g_i->size[0] = (int32_T)PopNum;
  SimValues->g_i->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(SimValues->g_i, i0);
  for (i0 = 0; i0 < (int32_T)PopNum * r1->size[1]; i0++) {
    SimValues->g_i->data[i0] = rtNaN;
  }

  i0 = SimValues->s->size[0] * SimValues->s->size[1];
  SimValues->s->size[0] = (int32_T)PopNum;
  SimValues->s->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(SimValues->s, i0);
  for (i0 = 0; i0 < (int32_T)PopNum * r1->size[1]; i0++) {
    SimValues->s->data[i0] = rtNaN;
  }

  i0 = SimValues->w->size[0] * SimValues->w->size[1];
  SimValues->w->size[0] = (int32_T)PopNum;
  SimValues->w->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(SimValues->w, i0);
  for (i0 = 0; i0 < (int32_T)PopNum * r1->size[1]; i0++) {
    SimValues->w->data[i0] = rtNaN;
  }

  i0 = SimValues->a_w->size[0] * SimValues->a_w->size[1];
  SimValues->a_w->size[0] = (int32_T)PopNum;
  SimValues->a_w->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(SimValues->a_w, i0);
  for (i0 = 0; i0 < (int32_T)PopNum * r1->size[1]; i0++) {
    SimValues->a_w->data[i0] = rtNaN;
  }

  i0 = SimValues->Input->size[0] * SimValues->Input->size[1];
  SimValues->Input->size[0] = (int32_T)PopNum;
  SimValues->Input->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(SimValues->Input, i0);
  for (i0 = 0; i0 < (int32_T)PopNum * r1->size[1]; i0++) {
    SimValues->Input->data[i0] = rtNaN;
  }

  emxFree_real_T(&r1);
  i0 = SimValues->t_weight->size[0] * SimValues->t_weight->size[1];
  SimValues->t_weight->size[0] = 1;
  SimValues->t_weight->size[1] = r2->size[1];
  emxEnsureCapacity_real_T(SimValues->t_weight, i0);
  for (i0 = 0; i0 < r2->size[1]; i0++) {
    SimValues->t_weight->data[i0] = rtNaN;
  }

  i0 = SimValues->WeightMat->size[0] * SimValues->WeightMat->size[1] *
    SimValues->WeightMat->size[2];
  SimValues->WeightMat->size[0] = (int32_T)PopNum;
  SimValues->WeightMat->size[1] = (int32_T)PopNum;
  SimValues->WeightMat->size[2] = r2->size[1];
  emxEnsureCapacity_real_T2(SimValues->WeightMat, i0);
  for (i0 = 0; i0 < (int32_T)PopNum * (int32_T)PopNum * r2->size[1]; i0++) {
    SimValues->WeightMat->data[i0] = rtNaN;
  }

  emxFree_real_T(&r2);
  emxInit_boolean_T(&b_x, 2, true);
  i0 = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 1;
  b_x->size[1] = recordVALs->size[1];
  emxEnsureCapacity_boolean_T(b_x, i0);
  for (loopUpperBound = 0; loopUpperBound < recordVALs->size[0] *
       recordVALs->size[1]; loopUpperBound++) {
    b_x->data[loopUpperBound] = (recordVALs->data[loopUpperBound] != 0);
  }

  emxInit_int32_T1(&b_ii, 2, true);
  nx = b_x->size[1];
  idx = 0;
  i0 = b_ii->size[0] * b_ii->size[1];
  b_ii->size[0] = 1;
  b_ii->size[1] = b_x->size[1];
  emxEnsureCapacity_int32_T1(b_ii, i0);
  nm1d2 = 1;
  exitg1 = false;
  while ((!exitg1) && (nm1d2 <= nx)) {
    if (b_x->data[nm1d2 - 1]) {
      idx++;
      b_ii->data[idx - 1] = nm1d2;
      if (idx >= nx) {
        exitg1 = true;
      } else {
        nm1d2++;
      }
    } else {
      nm1d2++;
    }
  }

  if (b_x->size[1] == 1) {
    if (idx == 0) {
      i0 = b_ii->size[0] * b_ii->size[1];
      b_ii->size[1] = 0;
      emxEnsureCapacity_int32_T1(b_ii, i0);
    }
  } else {
    i0 = b_ii->size[0] * b_ii->size[1];
    if (1 > idx) {
      b_ii->size[1] = 0;
    } else {
      b_ii->size[1] = idx;
    }

    emxEnsureCapacity_int32_T1(b_ii, i0);
  }

  emxFree_boolean_T(&b_x);
  emxInit_real32_T(&spikes, 2, true);
  ndbl = rt_roundd_snf((real_T)b_ii->size[1] * TimeParams->dt);
  i0 = spikes->size[0] * spikes->size[1];
  spikes->size[0] = (int32_T)(PopNum * ndbl * 20.0);
  spikes->size[1] = 2;
  emxEnsureCapacity_real32_T(spikes, i0);
  emxFree_int32_T(&b_ii);
  for (loopUpperBound = 0; loopUpperBound < (int32_T)(PopNum * ndbl * 20.0) * 2;
       loopUpperBound++) {
    spikes->data[loopUpperBound] = ((real32_T)rtNaN);
  }

  /* assume mean rate 20Hz */
  /*  if no spike adaptation, set to steady state????? or set to alpha(v_th) */
  n = b->size[0] - 1;
  nm1d2 = 0;
  for (mA = 0; mA <= n; mA++) {
    if (b->data[mA] == 0.0) {
      nm1d2++;
    }
  }

  emxInit_int32_T(&r15, 1, true);
  i0 = r15->size[0];
  r15->size[0] = nm1d2;
  emxEnsureCapacity_int32_T(r15, i0);
  nm1d2 = 0;
  for (mA = 0; mA <= n; mA++) {
    if (b->data[mA] == 0.0) {
      r15->data[nm1d2] = mA + 1;
      nm1d2++;
    }
  }

  n = b->size[0] - 1;
  nm1d2 = 0;
  for (mA = 0; mA <= n; mA++) {
    if (b->data[mA] == 0.0) {
      nm1d2++;
    }
  }

  emxInit_int32_T(&r16, 1, true);
  i0 = r16->size[0];
  r16->size[0] = nm1d2;
  emxEnsureCapacity_int32_T(r16, i0);
  nm1d2 = 0;
  for (mA = 0; mA <= n; mA++) {
    if (b->data[mA] == 0.0) {
      r16->data[nm1d2] = mA + 1;
      nm1d2++;
    }
  }

  emxInit_real_T1(&c_x, 1, true);
  i0 = c_x->size[0];
  c_x->size[0] = r16->size[0];
  emxEnsureCapacity_real_T1(c_x, i0);
  for (loopUpperBound = 0; loopUpperBound < r16->size[0]; loopUpperBound++) {
    c_x->data[loopUpperBound] = (V_reset->data[r16->data[loopUpperBound] - 1] -
      E_L->data[r16->data[loopUpperBound] - 1]) * delta_T->data[r16->
      data[loopUpperBound] - 1];
  }

  emxFree_int32_T(&r16);
  nx = c_x->size[0];
  for (ii = 0; ii < nx; ii++) {
    c_x->data[ii] = exp(c_x->data[ii]);
  }

  emxInit_real_T1(&r17, 1, true);
  i0 = r17->size[0];
  r17->size[0] = r15->size[0];
  emxEnsureCapacity_real_T1(r17, i0);
  for (loopUpperBound = 0; loopUpperBound < r15->size[0]; loopUpperBound++) {
    r17->data[loopUpperBound] = w_r->data[r15->data[loopUpperBound] - 1] *
      b_w->data[r15->data[loopUpperBound] - 1] / (1.0 - w_r->data[r15->
      data[loopUpperBound] - 1]) * c_x->data[loopUpperBound];
  }

  emxFree_real_T(&c_x);
  emxFree_int32_T(&r15);
  n = b->size[0];
  nm1d2 = 0;
  for (mA = 0; mA < n; mA++) {
    if (b->data[mA] == 0.0) {
      b->data[mA] = r17->data[nm1d2];
      nm1d2++;
    }
  }

  emxFree_real_T(&r17);
  emxInit_real_T1(&dX, 1, true);

  /*  If no noise */
  i0 = dX->size[0];
  dX->size[0] = 1;
  emxEnsureCapacity_real_T1(dX, i0);
  dX->data[0] = 0.0;

  /* V - Voltage Equation */
  /* s - Synaptic Output  */
  /* w - Adaptation Variable */
  /* x - Synaptic Trace for STDP */
  /*  Initial Conditions - random voltages */
  /* Improvement?: set # initial spiking neurons instead of hard coding  */
  /* range: E_L-Vth */
  /* chance of initial spiking  */
  cdiff = E_L->data[0];
  b_loopUpperBound = E_L->size[0];
  for (mA = 0; mA <= b_loopUpperBound - 2; mA++) {
    p = ((!rtIsNaN(E_L->data[mA + 1])) && (rtIsNaN(cdiff) || (cdiff > E_L->
           data[mA + 1])));
    if (p) {
      cdiff = E_L->data[mA + 1];
    }
  }

  ndbl = V_th->data[0];
  b_loopUpperBound = V_th->size[0];
  for (mA = 0; mA <= b_loopUpperBound - 2; mA++) {
    p = ((!rtIsNaN(V_th->data[mA + 1])) && (rtIsNaN(ndbl) || (ndbl < V_th->
           data[mA + 1])));
    if (p) {
      ndbl = V_th->data[mA + 1];
    }
  }

  emxInit_real_T1(&e_r, 1, true);

  /* make this neuron vector */
  ndbl -= cdiff;
  i0 = e_r->size[0];
  e_r->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(e_r, i0);
  if (!(e_r->size[0] == 0)) {
    emlrtRandu(&e_r->data[0], e_r->size[0]);
  }

  for (loopUpperBound = 0; loopUpperBound < e_r->size[0]; loopUpperBound++) {
    V->data[loopUpperBound] = cdiff + ndbl * e_r->data[loopUpperBound];
  }

  emxFree_real_T(&e_r);

  /*  Time Loop */
  savecounter = 1U;
  weightcounter = 1U;
  cdiff = 0.0;
  b_loopUpperBound = r0->size[1] - 1;
  emxFree_real_T(&r0);
  emxInit_real_T1(&PreIspikes, 1, true);
  emxInit_real_T1(&PostEspikes, 1, true);
  emxInit_real_T1(&r18, 1, true);
  emxInit_real_T1(&r19, 1, true);
  emxInit_real_T(&r20, 2, true);
  emxInit_int32_T(&r21, 1, true);
  emxInit_int32_T1(&r22, 2, true);
  emxInit_int32_T1(&r23, 2, true);
  emxInit_int32_T1(&r24, 2, true);
  emxInit_int32_T1(&r25, 2, true);
  emxInit_int32_T(&r26, 1, true);
  emxInit_int32_T(&r27, 1, true);
  emxInit_boolean_T1(&d_x, 1, true);
  emxInit_real_T1(&e_x, 1, true);
  emxInit_real_T1(&f_x, 1, true);
  emxInit_real_T1(&g_x, 1, true);
  emxInit_boolean_T1(&h_x, 1, true);
  emxInit_boolean_T1(&i_x, 1, true);
  emxInit_int32_T(&c_ii, 1, true);
  emxInitMatrix_cell_wrap_1(reshapes, true);
  emxInit_boolean_T1(&j_x, 1, true);
  emxInit_real_T1(&b_C, 1, true);
  emxInit_real_T1(&c_C, 1, true);
  emxInit_real_T1(&d_C, 1, true);
  emxInit_real_T1(&e_C, 1, true);
  emxInit_real_T1(&b_s, 1, true);
  emxInit_real_T1(&k_x, 1, true);
  emxInit_real_T(&b_EI_mat, 2, true);
  emxInit_real_T(&c_EI_mat, 2, true);
  emxInit_real_T1(&b_t_r, 1, true);
  if (0 <= b_loopUpperBound) {
    l_x = (int32_T)rt_roundd_snf((real_T)varargin_2 / 10.0);
    if ((!rtIsInf(-0.0 - TimeParams->dt)) && (!rtIsNaN(-0.0 - TimeParams->dt)))
    {
      if (-0.0 - TimeParams->dt == 0.0) {
        f_r = 0.0;
      } else {
        f_r = fmod(-0.0 - TimeParams->dt, 1.0);
        if (f_r == 0.0) {
          f_r = 0.0;
        } else {
          if (-0.0 - TimeParams->dt < 0.0) {
            f_r++;
          }
        }
      }

      if (-0.0 - TimeParams->dt == 0.0) {
        g_r = 0.0;
      } else {
        g_r = fmod(-0.0 - TimeParams->dt, 10.0);
        if (g_r == 0.0) {
          g_r = 0.0;
        } else {
          if (-0.0 - TimeParams->dt < 0.0) {
            g_r += 10.0;
          }
        }
      }
    } else {
      f_r = rtNaN;
      g_r = rtNaN;
    }
  }

  for (tt = 0; tt <= b_loopUpperBound; tt++) {
    /*     %% Time Counter */
    nm1d2 = 1 + tt;
    if (l_x != 0) {
      nm1d2 = (int32_T)fmod(1.0 + (real_T)tt, l_x);
    }

    if (nm1d2 == 0) {
      /* clearly, this needs improvement */
      c_y = NULL;
      m0 = emlrtCreateDoubleScalar(rt_roundd_snf(100.0 * (1.0 + (real_T)tt) /
        (real_T)varargin_2));
      emlrtAssign(&c_y, m0);
      emlrtDisplayR2012b(c_y, "ans", &emlrtRTEI, emlrtRootTLSGlobal);
    }

    /*     %% Dynamics: update noise, V,s,w based on values in previous timestep */
    /* Noise input (independent for each neuron... could also be correlated) */
    /* To do: precompte drive, so don't need random number generation each dt */
    i0 = d_x->size[0];
    d_x->size[0] = sigma->size[0];
    emxEnsureCapacity_boolean_T1(d_x, i0);
    for (loopUpperBound = 0; loopUpperBound < sigma->size[0]; loopUpperBound++)
    {
      d_x->data[loopUpperBound] = (sigma->data[loopUpperBound] != 0.0);
    }

    p = !(d_x->size[0] == 0);
    if (p) {
      k = 1;
      exitg1 = false;
      while ((!exitg1) && (k <= d_x->size[0])) {
        if (!d_x->data[k - 1]) {
          p = false;
          exitg1 = true;
        } else {
          k++;
        }
      }
    }

    if (p) {
      i0 = e_x->size[0];
      e_x->size[0] = theta->size[0];
      emxEnsureCapacity_real_T1(e_x, i0);
      for (loopUpperBound = 0; loopUpperBound < theta->size[0]; loopUpperBound++)
      {
        e_x->data[loopUpperBound] = 2.0 * theta->data[loopUpperBound];
      }

      nx = e_x->size[0];
      for (ii = 0; ii < nx; ii++) {
        e_x->data[ii] = sqrt(e_x->data[ii]);
      }

      i0 = r18->size[0];
      r18->size[0] = (int32_T)PopNum;
      emxEnsureCapacity_real_T1(r18, i0);
      if (!(r18->size[0] == 0)) {
        emlrtRandn(&r18->data[0], r18->size[0]);
      }

      ndbl = sqrt(dt);
      i0 = dX->size[0];
      dX->size[0] = theta->size[0];
      emxEnsureCapacity_real_T1(dX, i0);
      for (loopUpperBound = 0; loopUpperBound < theta->size[0]; loopUpperBound++)
      {
        dX->data[loopUpperBound] = -theta->data[loopUpperBound] * X_t->
          data[loopUpperBound] * dt + e_x->data[loopUpperBound] * sigma->
          data[loopUpperBound] * r18->data[loopUpperBound] * ndbl;
      }
    }

    /* V - Voltage Equation */
    /*                       %Leak */
    /*                       %Adaptation */
    /*        %Synapses */
    i0 = f_x->size[0];
    f_x->size[0] = g_L->size[0];
    emxEnsureCapacity_real_T1(f_x, i0);
    for (loopUpperBound = 0; loopUpperBound < g_L->size[0]; loopUpperBound++) {
      f_x->data[loopUpperBound] = ((((-g_L->data[loopUpperBound] * (V->
        data[loopUpperBound] - E_L->data[loopUpperBound]) - g_w->
        data[loopUpperBound] * (V->data[loopUpperBound] - E_w->
        data[loopUpperBound])) - g_e->data[loopUpperBound] * (V->
        data[loopUpperBound] - E_e->data[loopUpperBound])) - g_i->
        data[loopUpperBound] * (V->data[loopUpperBound] - E_i->
        data[loopUpperBound])) + I_e->data[loopUpperBound]) + X_t->
        data[loopUpperBound];
    }

    /* External input */
    /* s - Synaptic Output  */
    /* w - Adaptation Variable */
    /* x - Synaptic Trace for STDP */
    i0 = X_t->size[0];
    emxEnsureCapacity_real_T1(X_t, i0);
    for (loopUpperBound = 0; loopUpperBound < X_t->size[0]; loopUpperBound++) {
      X_t->data[loopUpperBound] += dX->data[loopUpperBound];
    }

    i0 = V->size[0];
    emxEnsureCapacity_real_T1(V, i0);
    for (loopUpperBound = 0; loopUpperBound < V->size[0]; loopUpperBound++) {
      V->data[loopUpperBound] += f_x->data[loopUpperBound] / C->
        data[loopUpperBound] * dt;
    }

    i0 = s->size[0];
    emxEnsureCapacity_real_T1(s, i0);
    for (loopUpperBound = 0; loopUpperBound < s->size[0]; loopUpperBound++) {
      s->data[loopUpperBound] += -s->data[loopUpperBound] / tau_s->
        data[loopUpperBound] * dt;
    }

    i0 = w->size[0];
    emxEnsureCapacity_real_T1(w, i0);
    for (loopUpperBound = 0; loopUpperBound < w->size[0]; loopUpperBound++) {
      w->data[loopUpperBound] += (a_w->data[loopUpperBound] * (1.0 - w->
        data[loopUpperBound]) - b_w->data[loopUpperBound] * w->
        data[loopUpperBound]) * dt;
    }

    i0 = x->size[0];
    emxEnsureCapacity_real_T1(x, i0);
    for (loopUpperBound = 0; loopUpperBound < x->size[0]; loopUpperBound++) {
      x->data[loopUpperBound] += -x->data[loopUpperBound] / tauSTDP->
        data[loopUpperBound] * dt;
    }

    /* timecounter = round(timecounter+dt,4);  %Round to deal with computational error */
    /* a_w - Adaptation activation rate for the next time step (unless spike) */
    i0 = g_x->size[0];
    g_x->size[0] = V->size[0];
    emxEnsureCapacity_real_T1(g_x, i0);
    for (loopUpperBound = 0; loopUpperBound < V->size[0]; loopUpperBound++) {
      g_x->data[loopUpperBound] = (V->data[loopUpperBound] - E_L->
        data[loopUpperBound]) * delta_T->data[loopUpperBound];
    }

    nx = g_x->size[0];
    for (ii = 0; ii < nx; ii++) {
      g_x->data[ii] = exp(g_x->data[ii]);
    }

    i0 = a_w->size[0];
    a_w->size[0] = w_r->size[0];
    emxEnsureCapacity_real_T1(a_w, i0);
    for (loopUpperBound = 0; loopUpperBound < w_r->size[0]; loopUpperBound++) {
      a_w->data[loopUpperBound] = w_r->data[loopUpperBound] * b_w->
        data[loopUpperBound] / (1.0 - w_r->data[loopUpperBound]) * g_x->
        data[loopUpperBound];
    }

    /*     %% Spiking */
    i0 = h_x->size[0];
    h_x->size[0] = V->size[0];
    emxEnsureCapacity_boolean_T1(h_x, i0);
    for (loopUpperBound = 0; loopUpperBound < V->size[0]; loopUpperBound++) {
      h_x->data[loopUpperBound] = (V->data[loopUpperBound] > V_th->
        data[loopUpperBound]);
    }

    p = false;
    nm1d2 = 1;
    exitg1 = false;
    while ((!exitg1) && (nm1d2 <= h_x->size[0])) {
      b0 = !h_x->data[nm1d2 - 1];
      if (!b0) {
        p = true;
        exitg1 = true;
      } else {
        nm1d2++;
      }
    }

    if (p) {
      /* Find neurons that crossed threshold and record the spiketimes  */
      i0 = i_x->size[0];
      i_x->size[0] = V->size[0];
      emxEnsureCapacity_boolean_T1(i_x, i0);
      for (loopUpperBound = 0; loopUpperBound < V->size[0]; loopUpperBound++) {
        i_x->data[loopUpperBound] = (V->data[loopUpperBound] > V_th->
          data[loopUpperBound]);
      }

      nx = i_x->size[0];
      idx = 0;
      i0 = c_ii->size[0];
      c_ii->size[0] = i_x->size[0];
      emxEnsureCapacity_int32_T(c_ii, i0);
      nm1d2 = 1;
      exitg1 = false;
      while ((!exitg1) && (nm1d2 <= nx)) {
        if (i_x->data[nm1d2 - 1]) {
          idx++;
          c_ii->data[idx - 1] = nm1d2;
          if (idx >= nx) {
            exitg1 = true;
          } else {
            nm1d2++;
          }
        } else {
          nm1d2++;
        }
      }

      if (i_x->size[0] == 1) {
        if (idx == 0) {
          i0 = c_ii->size[0];
          c_ii->size[0] = 0;
          emxEnsureCapacity_int32_T(c_ii, i0);
        }
      } else {
        i0 = c_ii->size[0];
        if (1 > idx) {
          c_ii->size[0] = 0;
        } else {
          c_ii->size[0] = idx;
        }

        emxEnsureCapacity_int32_T(c_ii, i0);
      }

      if (recordVALs->data[tt] != 0) {
        i0 = c_ii->size[0];
        nm1d2 = r21->size[0];
        r21->size[0] = (int32_T)((real_T)i0 - 1.0) + 1;
        emxEnsureCapacity_int32_T(r21, nm1d2);
        for (loopUpperBound = 0; loopUpperBound <= (int32_T)((real_T)i0 - 1.0);
             loopUpperBound++) {
          r21->data[loopUpperBound] = (int32_T)(cdiff + (1.0 + (real_T)
            loopUpperBound)) - 1;
        }

        i0 = reshapes[0].f1->size[0];
        reshapes[0].f1->size[0] = c_ii->size[0];
        emxEnsureCapacity_real_T1(reshapes[0].f1, i0);
        for (loopUpperBound = 0; loopUpperBound < c_ii->size[0]; loopUpperBound
             ++) {
          reshapes[0].f1->data[loopUpperBound] = -0.0 - dt;
        }

        nm1d2 = reshapes[0].f1->size[0] - 1;
        for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
          spikes->data[r21->data[loopUpperBound]] = (real32_T)reshapes[0]
            .f1->data[loopUpperBound];
        }

        nm1d2 = c_ii->size[0] - 1;
        for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
          spikes->data[r21->data[loopUpperBound] + spikes->size[0]] = (real32_T)
            c_ii->data[loopUpperBound];
        }
      }

      cdiff += (real_T)c_ii->size[0];

      /* Jump the conductance */
      i0 = b_s->size[0];
      b_s->size[0] = c_ii->size[0];
      emxEnsureCapacity_real_T1(b_s, i0);
      for (loopUpperBound = 0; loopUpperBound < c_ii->size[0]; loopUpperBound++)
      {
        b_s->data[loopUpperBound] = s->data[c_ii->data[loopUpperBound] - 1] +
          1.0;
      }

      for (loopUpperBound = 0; loopUpperBound < b_s->size[0]; loopUpperBound++)
      {
        s->data[c_ii->data[loopUpperBound] - 1] = b_s->data[loopUpperBound];
      }

      /* Set spiking neurons refractory period  */
      for (loopUpperBound = 0; loopUpperBound < c_ii->size[0]; loopUpperBound++)
      {
        t_r->data[c_ii->data[loopUpperBound] - 1] = t_ref->data[c_ii->
          data[loopUpperBound] - 1];
      }

      /* Jump the synaptic trace */
      i0 = k_x->size[0];
      k_x->size[0] = c_ii->size[0];
      emxEnsureCapacity_real_T1(k_x, i0);
      for (loopUpperBound = 0; loopUpperBound < c_ii->size[0]; loopUpperBound++)
      {
        k_x->data[loopUpperBound] = x->data[c_ii->data[loopUpperBound] - 1] +
          1.0;
      }

      for (loopUpperBound = 0; loopUpperBound < k_x->size[0]; loopUpperBound++)
      {
        x->data[c_ii->data[loopUpperBound] - 1] = k_x->data[loopUpperBound];
      }

      /* Implement STDP (Vogels 2011 SuppEqn 4/5) I->E only */
      /* Presynaptic I Cells */
      /* PreIspikes = intersect(spikeneurons,Icells); */
      n = c_ii->size[0] - 1;
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (c_ii->data[mA] > EPopNum) {
          nm1d2++;
        }
      }

      i0 = PreIspikes->size[0];
      PreIspikes->size[0] = nm1d2;
      emxEnsureCapacity_real_T1(PreIspikes, i0);
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (c_ii->data[mA] > EPopNum) {
          PreIspikes->data[nm1d2] = c_ii->data[mA];
          nm1d2++;
        }
      }

      n = EcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (EcellIDX->data[mA]) {
          nm1d2++;
        }
      }

      i0 = r22->size[0] * r22->size[1];
      r22->size[0] = 1;
      r22->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(r22, i0);
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (EcellIDX->data[mA]) {
          r22->data[nm1d2] = mA + 1;
          nm1d2++;
        }
      }

      i0 = r19->size[0];
      r19->size[0] = ELearningRate->size[0];
      emxEnsureCapacity_real_T1(r19, i0);
      for (loopUpperBound = 0; loopUpperBound < ELearningRate->size[0];
           loopUpperBound++) {
        r19->data[loopUpperBound] = ELearningRate->data[loopUpperBound] *
          (x->data[r22->data[r22->size[0] * loopUpperBound] - 1] - alpha->
           data[loopUpperBound]);
      }

      n = EcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (EcellIDX->data[mA]) {
          nm1d2++;
        }
      }

      i0 = r23->size[0] * r23->size[1];
      r23->size[0] = 1;
      r23->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(r23, i0);
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (EcellIDX->data[mA]) {
          r23->data[nm1d2] = mA + 1;
          nm1d2++;
        }
      }

      ndbl = r19->data[0];
      i0 = b_EI_mat->size[0] * b_EI_mat->size[1];
      b_EI_mat->size[0] = r23->size[1];
      b_EI_mat->size[1] = PreIspikes->size[0];
      emxEnsureCapacity_real_T(b_EI_mat, i0);
      for (i0 = 0; i0 < PreIspikes->size[0]; i0++) {
        for (loopUpperBound = 0; loopUpperBound < r23->size[1]; loopUpperBound++)
        {
          b_EI_mat->data[loopUpperBound + b_EI_mat->size[0] * i0] = EI_mat->
            data[(r23->data[r23->size[0] * loopUpperBound] + EI_mat->size[0] *
                  ((int32_T)PreIspikes->data[i0] - 1)) - 1] + ndbl;
        }
      }

      for (i0 = 0; i0 < b_EI_mat->size[1]; i0++) {
        for (loopUpperBound = 0; loopUpperBound < b_EI_mat->size[0];
             loopUpperBound++) {
          EI_mat->data[(r23->data[r23->size[0] * loopUpperBound] + EI_mat->size
                        [0] * ((int32_T)PreIspikes->data[i0] - 1)) - 1] =
            b_EI_mat->data[loopUpperBound + b_EI_mat->size[0] * i0];
        }
      }

      /* Postsynaptic E cells */
      /* PostEspikes = intersect(spikeneurons,Ecells); */
      n = c_ii->size[0] - 1;
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (c_ii->data[mA] <= EPopNum) {
          nm1d2++;
        }
      }

      i0 = PostEspikes->size[0];
      PostEspikes->size[0] = nm1d2;
      emxEnsureCapacity_real_T1(PostEspikes, i0);
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (c_ii->data[mA] <= EPopNum) {
          PostEspikes->data[nm1d2] = c_ii->data[mA];
          nm1d2++;
        }
      }

      n = IcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (IcellIDX->data[mA]) {
          nm1d2++;
        }
      }

      i0 = r24->size[0] * r24->size[1];
      r24->size[0] = 1;
      r24->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(r24, i0);
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (IcellIDX->data[mA]) {
          r24->data[nm1d2] = mA + 1;
          nm1d2++;
        }
      }

      i0 = r20->size[0] * r20->size[1];
      r20->size[0] = 1;
      r20->size[1] = ILearningRate->size[1];
      emxEnsureCapacity_real_T(r20, i0);
      for (loopUpperBound = 0; loopUpperBound < ILearningRate->size[0] *
           ILearningRate->size[1]; loopUpperBound++) {
        r20->data[loopUpperBound] = ILearningRate->data[loopUpperBound] *
          x->data[r24->data[loopUpperBound] - 1];
      }

      n = IcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (IcellIDX->data[mA]) {
          nm1d2++;
        }
      }

      i0 = r25->size[0] * r25->size[1];
      r25->size[0] = 1;
      r25->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(r25, i0);
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (IcellIDX->data[mA]) {
          r25->data[nm1d2] = mA + 1;
          nm1d2++;
        }
      }

      ndbl = r20->data[0];
      i0 = c_EI_mat->size[0] * c_EI_mat->size[1];
      c_EI_mat->size[0] = PostEspikes->size[0];
      c_EI_mat->size[1] = r25->size[1];
      emxEnsureCapacity_real_T(c_EI_mat, i0);
      for (i0 = 0; i0 < r25->size[1]; i0++) {
        for (loopUpperBound = 0; loopUpperBound < PostEspikes->size[0];
             loopUpperBound++) {
          c_EI_mat->data[loopUpperBound + c_EI_mat->size[0] * i0] = EI_mat->
            data[((int32_T)PostEspikes->data[loopUpperBound] + EI_mat->size[0] *
                  (r25->data[r25->size[0] * i0] - 1)) - 1] + ndbl;
        }
      }

      for (i0 = 0; i0 < c_EI_mat->size[1]; i0++) {
        for (loopUpperBound = 0; loopUpperBound < c_EI_mat->size[0];
             loopUpperBound++) {
          EI_mat->data[((int32_T)PostEspikes->data[loopUpperBound] +
                        EI_mat->size[0] * (r25->data[r25->size[0] * i0] - 1)) -
            1] = c_EI_mat->data[loopUpperBound + c_EI_mat->size[0] * i0];
        }
      }

      i0 = EI_mat->size[0] * EI_mat->size[1];
      nm1d2 = EI_mat->size[0] * EI_mat->size[1];
      emxEnsureCapacity_real_T(EI_mat, nm1d2);
      for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
        EI_mat->data[loopUpperBound] *= (real_T)isconnected->data[loopUpperBound];
      }

      /* Keep only connected pairs */
      n = EI_mat->size[0] * EI_mat->size[1] - 1;
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (EI_mat->data[mA] <= 0.0) {
          nm1d2++;
        }
      }

      i0 = r26->size[0];
      r26->size[0] = nm1d2;
      emxEnsureCapacity_int32_T(r26, i0);
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (EI_mat->data[mA] <= 0.0) {
          r26->data[nm1d2] = mA + 1;
          nm1d2++;
        }
      }

      i0 = r26->size[0];
      for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
        EI_mat->data[r26->data[loopUpperBound] - 1] = 0.0;
      }

      /* Get rid of any negative synapses... */
    }

    /*     %%  Refractory period Countdowns */
    i0 = j_x->size[0];
    j_x->size[0] = t_r->size[0];
    emxEnsureCapacity_boolean_T1(j_x, i0);
    for (loopUpperBound = 0; loopUpperBound < t_r->size[0]; loopUpperBound++) {
      j_x->data[loopUpperBound] = (t_r->data[loopUpperBound] > 0.0);
    }

    p = false;
    nm1d2 = 1;
    exitg1 = false;
    while ((!exitg1) && (nm1d2 <= j_x->size[0])) {
      b0 = !j_x->data[nm1d2 - 1];
      if (!b0) {
        p = true;
        exitg1 = true;
      } else {
        nm1d2++;
      }
    }

    if (p) {
      /* Hold voltage, synaptic/adaptation rates at spike levels */
      n = t_r->size[0] - 1;
      for (ii = 0; ii <= n; ii++) {
        if (t_r->data[ii] > 0.0) {
          V->data[ii] = V_reset->data[ii];
        }
      }

      n = t_r->size[0] - 1;
      for (ii = 0; ii <= n; ii++) {
        if (t_r->data[ii] > 0.0) {
          a_w->data[ii] = b->data[ii];
        }
      }

      /* Count down the refractory period */
      n = t_r->size[0] - 1;
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (t_r->data[mA] > 0.0) {
          nm1d2++;
        }
      }

      i0 = r27->size[0];
      r27->size[0] = nm1d2;
      emxEnsureCapacity_int32_T(r27, i0);
      nm1d2 = 0;
      for (mA = 0; mA <= n; mA++) {
        if (t_r->data[mA] > 0.0) {
          r27->data[nm1d2] = mA + 1;
          nm1d2++;
        }
      }

      i0 = b_t_r->size[0];
      b_t_r->size[0] = r27->size[0];
      emxEnsureCapacity_real_T1(b_t_r, i0);
      for (loopUpperBound = 0; loopUpperBound < r27->size[0]; loopUpperBound++)
      {
        b_t_r->data[loopUpperBound] = t_r->data[r27->data[loopUpperBound] - 1] -
          dt;
      }

      for (loopUpperBound = 0; loopUpperBound < b_t_r->size[0]; loopUpperBound++)
      {
        t_r->data[r27->data[loopUpperBound] - 1] = b_t_r->data[loopUpperBound];
      }
    }

    /*     %% Synaptic,Adaptaion Conductances for the next time step */
    i0 = g_w->size[0];
    g_w->size[0] = gwnorm->size[0];
    emxEnsureCapacity_real_T1(g_w, i0);
    for (loopUpperBound = 0; loopUpperBound < gwnorm->size[0]; loopUpperBound++)
    {
      g_w->data[loopUpperBound] = gwnorm->data[loopUpperBound] * w->
        data[loopUpperBound];
    }

    if ((EE_mat->size[1] == 1) || (s->size[0] == 1)) {
      i0 = b_C->size[0];
      b_C->size[0] = EE_mat->size[0];
      emxEnsureCapacity_real_T1(b_C, i0);
      nm1d2 = EE_mat->size[0] - 1;
      for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
        b_C->data[loopUpperBound] = 0.0;
        loop_ub = EE_mat->size[1] - 1;
        for (ii = 0; ii <= loop_ub; ii++) {
          b_C->data[loopUpperBound] += EE_mat->data[loopUpperBound +
            EE_mat->size[0] * ii] * s->data[ii];
        }
      }
    } else {
      mA = EE_mat->size[0];
      nA = EE_mat->size[1];
      if ((EE_mat->size[0] == 0) || (EE_mat->size[1] == 0) || (s->size[0] == 0))
      {
        i0 = b_C->size[0];
        b_C->size[0] = EE_mat->size[0];
        emxEnsureCapacity_real_T1(b_C, i0);
        for (loopUpperBound = 0; loopUpperBound < EE_mat->size[0];
             loopUpperBound++) {
          b_C->data[loopUpperBound] = 0.0;
        }
      } else {
        i0 = b_C->size[0];
        b_C->size[0] = EE_mat->size[0];
        emxEnsureCapacity_real_T1(b_C, i0);
        for (loopUpperBound = 0; loopUpperBound < EE_mat->size[0];
             loopUpperBound++) {
          b_C->data[loopUpperBound] = 0.0;
        }

        nm1d2 = 0;
        while ((mA > 0) && (nm1d2 <= 0)) {
          for (ii = 0; ii < mA; ii++) {
            b_C->data[ii] = 0.0;
          }

          nm1d2 = mA;
        }

        br = 0;
        nm1d2 = 0;
        while ((mA > 0) && (nm1d2 <= 0)) {
          i0 = br + nA;
          for (n = 0; n < i0 - br; n++) {
            idx = br + n;
            if (s->data[idx] != 0.0) {
              nx = nm1d2;
              for (k = 0; k < mA; k++) {
                nx++;
                b_C->data[k] += s->data[idx] * EE_mat->data[nx - 1];
              }
            }

            nm1d2 += mA;
          }

          br += nA;
          nm1d2 = mA;
        }
      }
    }

    if ((IE_mat->size[1] == 1) || (s->size[0] == 1)) {
      i0 = c_C->size[0];
      c_C->size[0] = IE_mat->size[0];
      emxEnsureCapacity_real_T1(c_C, i0);
      nm1d2 = IE_mat->size[0] - 1;
      for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
        c_C->data[loopUpperBound] = 0.0;
        loop_ub = IE_mat->size[1] - 1;
        for (ii = 0; ii <= loop_ub; ii++) {
          c_C->data[loopUpperBound] += IE_mat->data[loopUpperBound +
            IE_mat->size[0] * ii] * s->data[ii];
        }
      }
    } else {
      mA = IE_mat->size[0];
      nA = IE_mat->size[1];
      if ((IE_mat->size[0] == 0) || (IE_mat->size[1] == 0) || (s->size[0] == 0))
      {
        i0 = c_C->size[0];
        c_C->size[0] = IE_mat->size[0];
        emxEnsureCapacity_real_T1(c_C, i0);
        for (loopUpperBound = 0; loopUpperBound < IE_mat->size[0];
             loopUpperBound++) {
          c_C->data[loopUpperBound] = 0.0;
        }
      } else {
        i0 = c_C->size[0];
        c_C->size[0] = IE_mat->size[0];
        emxEnsureCapacity_real_T1(c_C, i0);
        for (loopUpperBound = 0; loopUpperBound < IE_mat->size[0];
             loopUpperBound++) {
          c_C->data[loopUpperBound] = 0.0;
        }

        nm1d2 = 0;
        while ((mA > 0) && (nm1d2 <= 0)) {
          for (ii = 0; ii < mA; ii++) {
            c_C->data[ii] = 0.0;
          }

          nm1d2 = mA;
        }

        br = 0;
        nm1d2 = 0;
        while ((mA > 0) && (nm1d2 <= 0)) {
          i0 = br + nA;
          for (n = 0; n < i0 - br; n++) {
            idx = br + n;
            if (s->data[idx] != 0.0) {
              nx = nm1d2;
              for (k = 0; k < mA; k++) {
                nx++;
                c_C->data[k] += s->data[idx] * IE_mat->data[nx - 1];
              }
            }

            nm1d2 += mA;
          }

          br += nA;
          nm1d2 = mA;
        }
      }
    }

    i0 = g_e->size[0];
    g_e->size[0] = b_C->size[0];
    emxEnsureCapacity_real_T1(g_e, i0);
    for (loopUpperBound = 0; loopUpperBound < b_C->size[0]; loopUpperBound++) {
      g_e->data[loopUpperBound] = b_C->data[loopUpperBound] + c_C->
        data[loopUpperBound];
    }

    if ((II_mat->size[1] == 1) || (s->size[0] == 1)) {
      i0 = d_C->size[0];
      d_C->size[0] = II_mat->size[0];
      emxEnsureCapacity_real_T1(d_C, i0);
      nm1d2 = II_mat->size[0] - 1;
      for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
        d_C->data[loopUpperBound] = 0.0;
        loop_ub = II_mat->size[1] - 1;
        for (ii = 0; ii <= loop_ub; ii++) {
          d_C->data[loopUpperBound] += II_mat->data[loopUpperBound +
            II_mat->size[0] * ii] * s->data[ii];
        }
      }
    } else {
      mA = II_mat->size[0];
      nA = II_mat->size[1];
      if ((II_mat->size[0] == 0) || (II_mat->size[1] == 0) || (s->size[0] == 0))
      {
        i0 = d_C->size[0];
        d_C->size[0] = II_mat->size[0];
        emxEnsureCapacity_real_T1(d_C, i0);
        for (loopUpperBound = 0; loopUpperBound < II_mat->size[0];
             loopUpperBound++) {
          d_C->data[loopUpperBound] = 0.0;
        }
      } else {
        i0 = d_C->size[0];
        d_C->size[0] = II_mat->size[0];
        emxEnsureCapacity_real_T1(d_C, i0);
        for (loopUpperBound = 0; loopUpperBound < II_mat->size[0];
             loopUpperBound++) {
          d_C->data[loopUpperBound] = 0.0;
        }

        nm1d2 = 0;
        while ((mA > 0) && (nm1d2 <= 0)) {
          for (ii = 0; ii < mA; ii++) {
            d_C->data[ii] = 0.0;
          }

          nm1d2 = mA;
        }

        br = 0;
        nm1d2 = 0;
        while ((mA > 0) && (nm1d2 <= 0)) {
          i0 = br + nA;
          for (n = 0; n < i0 - br; n++) {
            idx = br + n;
            if (s->data[idx] != 0.0) {
              nx = nm1d2;
              for (k = 0; k < mA; k++) {
                nx++;
                d_C->data[k] += s->data[idx] * II_mat->data[nx - 1];
              }
            }

            nm1d2 += mA;
          }

          br += nA;
          nm1d2 = mA;
        }
      }
    }

    if ((EI_mat->size[1] == 1) || (s->size[0] == 1)) {
      i0 = e_C->size[0];
      e_C->size[0] = EI_mat->size[0];
      emxEnsureCapacity_real_T1(e_C, i0);
      nm1d2 = EI_mat->size[0] - 1;
      for (loopUpperBound = 0; loopUpperBound <= nm1d2; loopUpperBound++) {
        e_C->data[loopUpperBound] = 0.0;
        loop_ub = EI_mat->size[1] - 1;
        for (ii = 0; ii <= loop_ub; ii++) {
          e_C->data[loopUpperBound] += EI_mat->data[loopUpperBound +
            EI_mat->size[0] * ii] * s->data[ii];
        }
      }
    } else {
      mA = EI_mat->size[0];
      nA = EI_mat->size[1];
      if ((EI_mat->size[0] == 0) || (EI_mat->size[1] == 0) || (s->size[0] == 0))
      {
        i0 = e_C->size[0];
        e_C->size[0] = EI_mat->size[0];
        emxEnsureCapacity_real_T1(e_C, i0);
        for (loopUpperBound = 0; loopUpperBound < EI_mat->size[0];
             loopUpperBound++) {
          e_C->data[loopUpperBound] = 0.0;
        }
      } else {
        i0 = e_C->size[0];
        e_C->size[0] = EI_mat->size[0];
        emxEnsureCapacity_real_T1(e_C, i0);
        for (loopUpperBound = 0; loopUpperBound < EI_mat->size[0];
             loopUpperBound++) {
          e_C->data[loopUpperBound] = 0.0;
        }

        nm1d2 = 0;
        while ((mA > 0) && (nm1d2 <= 0)) {
          for (ii = 0; ii < mA; ii++) {
            e_C->data[ii] = 0.0;
          }

          nm1d2 = mA;
        }

        br = 0;
        nm1d2 = 0;
        while ((mA > 0) && (nm1d2 <= 0)) {
          i0 = br + nA;
          for (n = 0; n < i0 - br; n++) {
            idx = br + n;
            if (s->data[idx] != 0.0) {
              nx = nm1d2;
              for (k = 0; k < mA; k++) {
                nx++;
                e_C->data[k] += s->data[idx] * EI_mat->data[nx - 1];
              }
            }

            nm1d2 += mA;
          }

          br += nA;
          nm1d2 = mA;
        }
      }
    }

    i0 = g_i->size[0];
    g_i->size[0] = d_C->size[0];
    emxEnsureCapacity_real_T1(g_i, i0);
    for (loopUpperBound = 0; loopUpperBound < d_C->size[0]; loopUpperBound++) {
      g_i->data[loopUpperBound] = d_C->data[loopUpperBound] + e_C->
        data[loopUpperBound];
    }

    /*     %% Add data to the output variables */
    /* Question: is accessing structure slower than doubles? */
    if ((f_r == 0.0) && (-0.0 - dt >= 0.0) && (recordVALs->data[tt] != 0)) {
      SimValues->t->data[(int32_T)savecounter - 1] = -0.0 - dt;
      for (i0 = 0; i0 < V->size[0]; i0++) {
        SimValues->V->data[i0 + SimValues->V->size[0] * ((int32_T)savecounter -
          1)] = V->data[i0];
      }

      for (i0 = 0; i0 < g_w->size[0]; i0++) {
        SimValues->g_w->data[i0 + SimValues->g_w->size[0] * ((int32_T)
          savecounter - 1)] = g_w->data[i0];
      }

      for (i0 = 0; i0 < g_e->size[0]; i0++) {
        SimValues->g_e->data[i0 + SimValues->g_e->size[0] * ((int32_T)
          savecounter - 1)] = g_e->data[i0];
      }

      for (i0 = 0; i0 < g_i->size[0]; i0++) {
        SimValues->g_i->data[i0 + SimValues->g_i->size[0] * ((int32_T)
          savecounter - 1)] = g_i->data[i0];
      }

      for (i0 = 0; i0 < s->size[0]; i0++) {
        SimValues->s->data[i0 + SimValues->s->size[0] * ((int32_T)savecounter -
          1)] = s->data[i0];
      }

      for (i0 = 0; i0 < w->size[0]; i0++) {
        SimValues->w->data[i0 + SimValues->w->size[0] * ((int32_T)savecounter -
          1)] = w->data[i0];
      }

      for (i0 = 0; i0 < a_w->size[0]; i0++) {
        SimValues->a_w->data[i0 + SimValues->a_w->size[0] * ((int32_T)
          savecounter - 1)] = a_w->data[i0];
      }

      for (i0 = 0; i0 < I_e->size[0]; i0++) {
        SimValues->Input->data[i0 + SimValues->Input->size[0] * ((int32_T)
          savecounter - 1)] = I_e->data[i0] + X_t->data[i0];
      }

      savecounter++;
    }

    /* Save the weights (less frequently for space concerns) */
    if ((g_r == 0.0) && (-0.0 - dt >= 0.0) && (recordVALs->data[tt] != 0)) {
      SimValues->t_weight->data[(int32_T)weightcounter - 1] = -0.0 - dt;
      for (i0 = 0; i0 < EE_mat->size[1]; i0++) {
        for (nm1d2 = 0; nm1d2 < EE_mat->size[0]; nm1d2++) {
          SimValues->WeightMat->data[(nm1d2 + SimValues->WeightMat->size[0] * i0)
            + SimValues->WeightMat->size[0] * SimValues->WeightMat->size[1] *
            ((int32_T)weightcounter - 1)] = ((EE_mat->data[nm1d2 + EE_mat->size
            [0] * i0] + II_mat->data[nm1d2 + II_mat->size[0] * i0]) +
            EI_mat->data[nm1d2 + EI_mat->size[0] * i0]) + IE_mat->data[nm1d2 +
            IE_mat->size[0] * i0];
        }
      }

      weightcounter++;
    }

    /* Idea: add a catch for silent network or excessive firing network? */
  }

  emxFree_real_T(&b_t_r);
  emxFree_real_T(&c_EI_mat);
  emxFree_real_T(&b_EI_mat);
  emxFree_real_T(&k_x);
  emxFree_real_T(&b_s);
  emxFree_real_T(&e_C);
  emxFree_real_T(&d_C);
  emxFree_real_T(&c_C);
  emxFree_real_T(&b_C);
  emxFree_boolean_T(&j_x);
  emxFreeMatrix_cell_wrap_1(reshapes);
  emxFree_int32_T(&c_ii);
  emxFree_boolean_T(&i_x);
  emxFree_boolean_T(&h_x);
  emxFree_real_T(&g_x);
  emxFree_real_T(&f_x);
  emxFree_real_T(&e_x);
  emxFree_boolean_T(&d_x);
  emxFree_int32_T(&r27);
  emxFree_int32_T(&r26);
  emxFree_int32_T(&r25);
  emxFree_int32_T(&r24);
  emxFree_int32_T(&r23);
  emxFree_int32_T(&r22);
  emxFree_int32_T(&r21);
  emxFree_real_T(&r20);
  emxFree_real_T(&r19);
  emxFree_real_T(&r18);
  emxFree_real_T(&PostEspikes);
  emxFree_real_T(&PreIspikes);
  emxFree_real_T(&dX);
  emxFree_real_T(&x);
  emxFree_real_T(&t_r);
  emxFree_real_T(&X_t);
  emxFree_real_T(&w);
  emxFree_real_T(&s);
  emxFree_real_T(&a_w);
  emxFree_real_T(&g_w);
  emxFree_real_T(&g_i);
  emxFree_real_T(&g_e);
  emxFree_real_T(&V);
  emxFree_real_T(&alpha);
  emxFree_real_T(&tauSTDP);
  emxFree_real_T(&ILearningRate);
  emxFree_real_T(&ELearningRate);
  emxFree_real_T(&tau_s);
  emxFree_real_T(&E_i);
  emxFree_real_T(&E_e);
  emxFree_real_T(&b);
  emxFree_real_T(&w_r);
  emxFree_real_T(&gwnorm);
  emxFree_real_T(&delta_T);
  emxFree_real_T(&b_w);
  emxFree_real_T(&E_w);
  emxFree_real_T(&theta);
  emxFree_real_T(&sigma);
  emxFree_real_T(&t_ref);
  emxFree_real_T(&V_reset);
  emxFree_real_T(&V_th);
  emxFree_real_T(&I_e);
  emxFree_real_T(&C);
  emxFree_real_T(&g_L);
  emxFree_real_T(&E_L);
  emxFree_boolean_T(&isconnected);
  emxFree_boolean_T(&IcellIDX);
  emxFree_boolean_T(&EcellIDX);
  emxFree_real_T(&EI_mat);
  emxFree_real_T(&IE_mat);
  emxFree_real_T(&II_mat);
  emxFree_real_T(&EE_mat);
  emxFree_int8_T(&recordVALs);
  emxInit_int32_T1(&b_idx, 2, true);

  /*  */
  /* Catch for no spiking in simulation error */
  ndbl = cdiff + 1.0;
  i0 = spikes->size[0];
  nm1d2 = b_idx->size[0] * b_idx->size[1];
  b_idx->size[0] = 1;
  b_idx->size[1] = (int32_T)((real_T)i0 - (cdiff + 1.0)) + 1;
  emxEnsureCapacity_int32_T1(b_idx, nm1d2);
  for (loopUpperBound = 0; loopUpperBound <= (int32_T)((real_T)i0 - ndbl);
       loopUpperBound++) {
    b_idx->data[b_idx->size[0] * loopUpperBound] = (int32_T)((cdiff + 1.0) +
      (real_T)loopUpperBound);
  }

  br = spikes->size[0] - 1;
  if (b_idx->size[1] == 1) {
    idx = spikes->size[0] - 1;
    for (nx = 0; nx < 2; nx++) {
      nm1d2 = b_idx->data[0];
      for (mA = 0; mA <= br - nm1d2; mA++) {
        n = nm1d2 + mA;
        spikes->data[(n + spikes->size[0] * nx) - 1] = spikes->data[n +
          spikes->size[0] * nx];
      }
    }
  } else {
    emxInit_boolean_T(&b_b, 2, true);
    i0 = b_b->size[0] * b_b->size[1];
    b_b->size[0] = 1;
    b_b->size[1] = spikes->size[0];
    emxEnsureCapacity_boolean_T(b_b, i0);
    for (loopUpperBound = 0; loopUpperBound < spikes->size[0]; loopUpperBound++)
    {
      b_b->data[loopUpperBound] = false;
    }

    b_loopUpperBound = b_idx->size[1];
    for (ii = 0; ii < b_loopUpperBound; ii++) {
      b_b->data[b_idx->data[ii] - 1] = true;
    }

    n = 0;
    b_loopUpperBound = b_b->size[1];
    for (k = 0; k < b_loopUpperBound; k++) {
      n += b_b->data[k];
    }

    idx = spikes->size[0] - n;
    mA = 0;
    for (k = 0; k <= br; k++) {
      if ((1 + k > b_b->size[1]) || (!b_b->data[k])) {
        for (nx = 0; nx < 2; nx++) {
          spikes->data[mA + spikes->size[0] * nx] = spikes->data[k +
            spikes->size[0] * nx];
        }

        mA++;
      }
    }

    emxFree_boolean_T(&b_b);
  }

  emxFree_int32_T(&b_idx);
  if (1 > idx) {
    i0 = 0;
  } else {
    i0 = idx;
  }

  emxInit_real32_T(&b_spikes, 2, true);
  nm1d2 = b_spikes->size[0] * b_spikes->size[1];
  b_spikes->size[0] = i0;
  b_spikes->size[1] = 2;
  emxEnsureCapacity_real32_T(b_spikes, nm1d2);
  for (nm1d2 = 0; nm1d2 < 2; nm1d2++) {
    for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
      b_spikes->data[loopUpperBound + b_spikes->size[0] * nm1d2] = spikes->
        data[loopUpperBound + spikes->size[0] * nm1d2];
    }
  }

  i0 = spikes->size[0] * spikes->size[1];
  spikes->size[0] = b_spikes->size[0];
  spikes->size[1] = 2;
  emxEnsureCapacity_real32_T(spikes, i0);
  for (i0 = 0; i0 < 2; i0++) {
    for (loopUpperBound = 0; loopUpperBound < b_spikes->size[0]; loopUpperBound
         ++) {
      spikes->data[loopUpperBound + spikes->size[0] * i0] = b_spikes->
        data[loopUpperBound + b_spikes->size[0] * i0];
    }
  }

  emxFree_real32_T(&b_spikes);

  /* if isempty(spikes); spikes = [nan nan]; end */
  /*  Figure */
  emlrtRandu(&ndbl, 1);
  i0 = spikes->size[0];
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    emxInit_boolean_T1(&r28, 1, true);
    emxFree_boolean_T(&r28);
  }

  emxInit_real32_T1(&u, 1, true);
  figure(&emlrtMCI);
  i0 = spikes->size[0];
  nm1d2 = u->size[0];
  u->size[0] = i0;
  emxEnsureCapacity_real32_T1(u, nm1d2);
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    u->data[loopUpperBound] = spikes->data[loopUpperBound];
  }

  c_y = NULL;
  m0 = emlrtCreateNumericArray(1, *(int32_T (*)[1])u->size, mxSINGLE_CLASS,
    mxREAL);
  pData = (real32_T *)emlrtMxGetData(m0);
  i0 = 0;
  b_loopUpperBound = spikes->size[0];
  emxFree_real32_T(&u);
  for (mA = 0; mA < b_loopUpperBound; mA++) {
    pData[i0] = spikes->data[mA];
    i0++;
  }

  emxInit_real32_T1(&b_u, 1, true);
  emlrtAssign(&c_y, m0);
  i0 = spikes->size[0];
  nm1d2 = b_u->size[0];
  b_u->size[0] = i0;
  emxEnsureCapacity_real32_T1(b_u, nm1d2);
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    b_u->data[loopUpperBound] = spikes->data[loopUpperBound + spikes->size[0]];
  }

  d_y = NULL;
  m0 = emlrtCreateNumericArray(1, *(int32_T (*)[1])b_u->size, mxSINGLE_CLASS,
    mxREAL);
  pData = (real32_T *)emlrtMxGetData(m0);
  i0 = 0;
  b_loopUpperBound = spikes->size[0];
  emxFree_real32_T(&b_u);
  for (mA = 0; mA < b_loopUpperBound; mA++) {
    pData[i0] = spikes->data[mA + spikes->size[0]];
    i0++;
  }

  emlrtAssign(&d_y, m0);
  e_y = NULL;
  m0 = emlrtCreateCharArray(2, iv1);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m0, &c_u[0]);
  emlrtAssign(&e_y, m0);
  f_y = NULL;
  m0 = emlrtCreateCharArray(2, iv2);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 10, m0, &d_u[0]);
  emlrtAssign(&f_y, m0);
  g_y = NULL;
  m0 = emlrtCreateDoubleScalar(0.1);
  emlrtAssign(&g_y, m0);
  plot(c_y, d_y, e_y, f_y, g_y, &b_emlrtMCI);
  c_y = NULL;
  m0 = emlrtCreateCharArray(2, iv3);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m0, &e_u[0]);
  emlrtAssign(&c_y, m0);
  hold(c_y, &c_emlrtMCI);
  c_y = NULL;
  m0 = emlrtCreateNumericArray(2, iv4, mxDOUBLE_CLASS, mxREAL);
  b_pData = emlrtMxGetPr(m0);
  for (mA = 0; mA < 2; mA++) {
    b_pData[mA] = 0.0;
  }

  emlrtAssign(&c_y, m0);
  V0range[0] = 0.0;
  V0range[1] = PopNum;
  d_y = NULL;
  m0 = emlrtCreateNumericArray(2, iv5, mxDOUBLE_CLASS, mxREAL);
  b_pData = emlrtMxGetPr(m0);
  for (mA = 0; mA < 2; mA++) {
    b_pData[mA] = V0range[mA];
  }

  emlrtAssign(&d_y, m0);
  e_y = NULL;
  m0 = emlrtCreateString1('r');
  emlrtAssign(&e_y, m0);
  b_plot(c_y, d_y, e_y, &d_emlrtMCI);
  c_y = NULL;
  m0 = emlrtCreateCharArray(2, iv6);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 9, m0, &f_u[0]);
  emlrtAssign(&c_y, m0);
  xlabel(c_y, &e_emlrtMCI);
  c_y = NULL;
  m0 = emlrtCreateCharArray(2, iv7);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 9, m0, &g_u[0]);
  emlrtAssign(&c_y, m0);
  ylabel(c_y, &f_emlrtMCI);
  c_y = NULL;
  m0 = emlrtCreateCharArray(2, iv8);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 11, m0, &h_u[0]);
  emlrtAssign(&c_y, m0);
  title(c_y, &g_emlrtMCI);
  V0range[0] = -0.0;
  V0range[1] = TimeParams->SimTime;
  c_y = NULL;
  m0 = emlrtCreateNumericArray(2, iv9, mxDOUBLE_CLASS, mxREAL);
  b_pData = emlrtMxGetPr(m0);
  for (mA = 0; mA < 2; mA++) {
    b_pData[mA] = V0range[mA];
  }

  emlrtAssign(&c_y, m0);
  xlim(c_y, &h_emlrtMCI);
  V0range[0] = 0.0;
  V0range[1] = PopNum + 1.0;
  c_y = NULL;
  m0 = emlrtCreateNumericArray(2, iv10, mxDOUBLE_CLASS, mxREAL);
  b_pData = emlrtMxGetPr(m0);
  for (mA = 0; mA < 2; mA++) {
    b_pData[mA] = V0range[mA];
  }

  emxInit_boolean_T1(&c_idx, 1, true);
  emlrtAssign(&c_y, m0);
  ylim(c_y, &i_emlrtMCI);

  /*  Output Structure */
  /* Remove onset time */
  i0 = spikes->size[0];
  nm1d2 = c_idx->size[0];
  c_idx->size[0] = i0;
  emxEnsureCapacity_boolean_T1(c_idx, nm1d2);
  for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
    c_idx->data[loopUpperBound] = (spikes->data[loopUpperBound] <= 0.0F);
  }

  br = spikes->size[0];
  n = 0;
  b_loopUpperBound = c_idx->size[0];
  for (k = 0; k < b_loopUpperBound; k++) {
    n += c_idx->data[k];
  }

  idx = spikes->size[0] - n;
  mA = 0;
  for (k = 0; k < br; k++) {
    if ((1 + k > c_idx->size[0]) || (!c_idx->data[k])) {
      for (nx = 0; nx < 2; nx++) {
        spikes->data[mA + spikes->size[0] * nx] = spikes->data[k + spikes->size
          [0] * nx];
      }

      mA++;
    }
  }

  emxFree_boolean_T(&c_idx);
  if (1 > idx) {
    i0 = 0;
  } else {
    i0 = idx;
  }

  emxInit_real32_T(&c_spikes, 2, true);
  nm1d2 = c_spikes->size[0] * c_spikes->size[1];
  c_spikes->size[0] = i0;
  c_spikes->size[1] = 2;
  emxEnsureCapacity_real32_T(c_spikes, nm1d2);
  for (nm1d2 = 0; nm1d2 < 2; nm1d2++) {
    for (loopUpperBound = 0; loopUpperBound < i0; loopUpperBound++) {
      c_spikes->data[loopUpperBound + c_spikes->size[0] * nm1d2] = spikes->
        data[loopUpperBound + spikes->size[0] * nm1d2];
    }
  }

  i0 = spikes->size[0] * spikes->size[1];
  spikes->size[0] = c_spikes->size[0];
  spikes->size[1] = 2;
  emxEnsureCapacity_real32_T(spikes, i0);
  for (i0 = 0; i0 < 2; i0++) {
    for (loopUpperBound = 0; loopUpperBound < c_spikes->size[0]; loopUpperBound
         ++) {
      spikes->data[loopUpperBound + spikes->size[0] * i0] = c_spikes->
        data[loopUpperBound + c_spikes->size[0] * i0];
    }
  }

  emxFree_real32_T(&c_spikes);

  /* if cellout */
  /*     for cc = 1:PopNum %This can go very slow with lots of spikes.... */
  /*         spikesbycell{cc} = spikes(spikes(:,2)==cc,1); */
  /*     end */
  /*     SimValues.spikesbycell    = spikesbycell; */
  /* end */
  i0 = SimValues->spikes->size[0] * SimValues->spikes->size[1];
  SimValues->spikes->size[0] = spikes->size[0];
  SimValues->spikes->size[1] = 2;
  emxEnsureCapacity_real32_T(SimValues->spikes, i0);
  for (i0 = 0; i0 < spikes->size[0] * spikes->size[1]; i0++) {
    SimValues->spikes->data[i0] = spikes->data[i0];
  }

  emxFree_real32_T(&spikes);
  i0 = SimValues->EcellIDX->size[0] * SimValues->EcellIDX->size[1];
  SimValues->EcellIDX->size[0] = 1;
  SimValues->EcellIDX->size[1] = Ecells->size[1];
  emxEnsureCapacity_real_T(SimValues->EcellIDX, i0);
  for (i0 = 0; i0 < Ecells->size[0] * Ecells->size[1]; i0++) {
    SimValues->EcellIDX->data[i0] = Ecells->data[i0];
  }

  emxFree_real_T(&Ecells);
  i0 = SimValues->IcellIDX->size[0] * SimValues->IcellIDX->size[1];
  SimValues->IcellIDX->size[0] = 1;
  SimValues->IcellIDX->size[1] = Icells->size[1];
  emxEnsureCapacity_real_T(SimValues->IcellIDX, i0);
  for (i0 = 0; i0 < Icells->size[0] * Icells->size[1]; i0++) {
    SimValues->IcellIDX->data[i0] = Icells->data[i0];
  }

  emxFree_real_T(&Icells);

  /* SimValues.WeightMat       = EE_mat+II_mat+EI_mat+IE_mat; */
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  CUDACHECK(cudaFree(gpu_recordIntervals));
  CUDACHECK(cudaFree(gpu_saveINT));

#undef CUDACHECK

}

/* End of code generation (CAdLIFfunction_STDP.cu) */
