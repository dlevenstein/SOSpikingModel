/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * CAdLIFfunction_STDP.c
 *
 * Code generation for function 'CAdLIFfunction_STDP'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "randi.h"
#include "CAdLIFfunction_STDP_emxutil.h"
#include "toLogicalCheck.h"
#include "mod.h"
#include "any.h"
#include "eml_int_forloop_overflow_check.h"
#include "exp.h"
#include "rdivide.h"
#include "sqrt.h"
#include "randn.h"
#include "ifWhileCond.h"
#include "nullAssignment.h"
#include "diff.h"
#include "rand.h"
#include "unaryMinOrMax.h"
#include "diag.h"
#include "createRecorder.h"
#include "CAdLIFfunction_STDP_data.h"
#include "blas.h"

/* Variable Definitions */
static emlrtRTEInfo emlrtRTEI = { 403, /* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRSInfo emlrtRSI = { 86,    /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 100, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 112, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 133, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 135, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 142, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 144, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo h_emlrtRSI = { 151, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 159, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 364, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 368, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 392, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo m_emlrtRSI = { 393, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo n_emlrtRSI = { 409, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo o_emlrtRSI = { 410, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo p_emlrtRSI = { 414, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo q_emlrtRSI = { 420, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo r_emlrtRSI = { 424, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo s_emlrtRSI = { 435, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo t_emlrtRSI = { 439, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo u_emlrtRSI = { 441, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo v_emlrtRSI = { 445, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo w_emlrtRSI = { 447, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo x_emlrtRSI = { 478, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo y_emlrtRSI = { 490, /* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo ab_emlrtRSI = { 491,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo bb_emlrtRSI = { 497,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo cb_emlrtRSI = { 515,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo db_emlrtRSI = { 534,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo eb_emlrtRSI = { 527,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo fb_emlrtRSI = { 547,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo jb_emlrtRSI = { 290,/* lineNo */
  "colon",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m"/* pathName */
};

static emlrtRSInfo lb_emlrtRSI = { 25, /* lineNo */
  "colon",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m"/* pathName */
};

static emlrtRSInfo nb_emlrtRSI = { 41, /* lineNo */
  "find",                              /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"/* pathName */
};

static emlrtRSInfo ob_emlrtRSI = { 153,/* lineNo */
  "find",                              /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"/* pathName */
};

static emlrtRSInfo pb_emlrtRSI = { 377,/* lineNo */
  "find",                              /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"/* pathName */
};

static emlrtRSInfo sb_emlrtRSI = { 13, /* lineNo */
  "min",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\datafun\\min.m"/* pathName */
};

static emlrtRSInfo tb_emlrtRSI = { 19, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo ub_emlrtRSI = { 40, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo vb_emlrtRSI = { 114,/* lineNo */
  "unaryMinOrMax",                     /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\unaryMinOrMax.m"/* pathName */
};

static emlrtRSInfo wb_emlrtRSI = { 852,/* lineNo */
  "unaryMinOrMax",                     /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\unaryMinOrMax.m"/* pathName */
};

static emlrtRSInfo xb_emlrtRSI = { 844,/* lineNo */
  "unaryMinOrMax",                     /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\unaryMinOrMax.m"/* pathName */
};

static emlrtRSInfo ac_emlrtRSI = { 910,/* lineNo */
  "unaryMinOrMax",                     /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\unaryMinOrMax.m"/* pathName */
};

static emlrtRSInfo bc_emlrtRSI = { 13, /* lineNo */
  "max",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\datafun\\max.m"/* pathName */
};

static emlrtRSInfo ic_emlrtRSI = { 397,/* lineNo */
  "find",                              /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"/* pathName */
};

static emlrtRSInfo jc_emlrtRSI = { 18, /* lineNo */
  "indexShapeCheck",                   /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"/* pathName */
};

static emlrtRSInfo lc_emlrtRSI = { 20, /* lineNo */
  "cat",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\cat.m"/* pathName */
};

static emlrtRSInfo mc_emlrtRSI = { 100,/* lineNo */
  "cat",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\cat.m"/* pathName */
};

static emlrtRSInfo nc_emlrtRSI = { 52, /* lineNo */
  "eml_mtimes_helper",                 /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"/* pathName */
};

static emlrtRSInfo oc_emlrtRSI = { 21, /* lineNo */
  "eml_mtimes_helper",                 /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"/* pathName */
};

static emlrtRSInfo pc_emlrtRSI = { 114,/* lineNo */
  "mtimes",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\+blas\\mtimes.m"/* pathName */
};

static emlrtRSInfo qc_emlrtRSI = { 118,/* lineNo */
  "mtimes",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\+blas\\mtimes.m"/* pathName */
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

static emlrtRTEInfo b_emlrtRTEI = { 100,/* lineNo */
  25,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo c_emlrtRTEI = { 101,/* lineNo */
  26,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo d_emlrtRTEI = { 102,/* lineNo */
  28,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo e_emlrtRTEI = { 106,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo g_emlrtRTEI = { 107,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo h_emlrtRTEI = { 108,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo i_emlrtRTEI = { 109,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo j_emlrtRTEI = { 111,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo k_emlrtRTEI = { 25,/* lineNo */
  9,                                   /* colNo */
  "colon",                             /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m"/* pName */
};

static emlrtRTEInfo l_emlrtRTEI = { 111,/* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo m_emlrtRTEI = { 112,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo n_emlrtRTEI = { 112,/* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo o_emlrtRTEI = { 133,/* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo p_emlrtRTEI = { 133,/* lineNo */
  19,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo q_emlrtRTEI = { 133,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo r_emlrtRTEI = { 134,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo s_emlrtRTEI = { 135,/* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo t_emlrtRTEI = { 57,/* lineNo */
  24,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo u_emlrtRTEI = { 142,/* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo v_emlrtRTEI = { 142,/* lineNo */
  19,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo w_emlrtRTEI = { 142,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo x_emlrtRTEI = { 143,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo y_emlrtRTEI = { 144,/* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ab_emlrtRTEI = { 151,/* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo bb_emlrtRTEI = { 151,/* lineNo */
  19,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo cb_emlrtRTEI = { 151,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo db_emlrtRTEI = { 152,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo eb_emlrtRTEI = { 159,/* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo fb_emlrtRTEI = { 159,/* lineNo */
  19,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo gb_emlrtRTEI = { 159,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo hb_emlrtRTEI = { 160,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ib_emlrtRTEI = { 163,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo jb_emlrtRTEI = { 209,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo kb_emlrtRTEI = { 215,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo lb_emlrtRTEI = { 221,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo mb_emlrtRTEI = { 229,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo nb_emlrtRTEI = { 233,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ob_emlrtRTEI = { 239,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo pb_emlrtRTEI = { 247,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo qb_emlrtRTEI = { 253,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo rb_emlrtRTEI = { 259,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo sb_emlrtRTEI = { 265,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo tb_emlrtRTEI = { 271,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ub_emlrtRTEI = { 277,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo vb_emlrtRTEI = { 283,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo wb_emlrtRTEI = { 289,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo xb_emlrtRTEI = { 295,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo yb_emlrtRTEI = { 301,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ac_emlrtRTEI = { 307,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo bc_emlrtRTEI = { 311,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo cc_emlrtRTEI = { 316,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo dc_emlrtRTEI = { 317,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ec_emlrtRTEI = { 319,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo fc_emlrtRTEI = { 321,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo gc_emlrtRTEI = { 334,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo hc_emlrtRTEI = { 335,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ic_emlrtRTEI = { 336,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo jc_emlrtRTEI = { 337,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo kc_emlrtRTEI = { 338,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo lc_emlrtRTEI = { 339,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo mc_emlrtRTEI = { 340,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo nc_emlrtRTEI = { 341,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo oc_emlrtRTEI = { 342,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo pc_emlrtRTEI = { 344,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo qc_emlrtRTEI = { 347,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo rc_emlrtRTEI = { 348,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo sc_emlrtRTEI = { 349,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo tc_emlrtRTEI = { 350,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo uc_emlrtRTEI = { 351,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo vc_emlrtRTEI = { 352,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo wc_emlrtRTEI = { 353,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo xc_emlrtRTEI = { 354,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo yc_emlrtRTEI = { 355,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ad_emlrtRTEI = { 356,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo bd_emlrtRTEI = { 357,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo cd_emlrtRTEI = { 364,/* lineNo */
  41,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo dd_emlrtRTEI = { 153,/* lineNo */
  13,                                  /* colNo */
  "find",                              /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"/* pName */
};

static emlrtRTEInfo ed_emlrtRTEI = { 41,/* lineNo */
  5,                                   /* colNo */
  "find",                              /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"/* pName */
};

static emlrtRTEInfo fd_emlrtRTEI = { 364,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo gd_emlrtRTEI = { 368,/* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo hd_emlrtRTEI = { 368,/* lineNo */
  34,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo id_emlrtRTEI = { 368,/* lineNo */
  50,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo jd_emlrtRTEI = { 371,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo kd_emlrtRTEI = { 393,/* lineNo */
  7,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ld_emlrtRTEI = { 393,/* lineNo */
  27,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo md_emlrtRTEI = { 527,/* lineNo */
  8,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo nd_emlrtRTEI = { 409,/* lineNo */
  8,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo od_emlrtRTEI = { 410,/* lineNo */
  14,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo pd_emlrtRTEI = { 535,/* lineNo */
  23,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo qd_emlrtRTEI = { 410,/* lineNo */
  32,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo rd_emlrtRTEI = { 414,/* lineNo */
  14,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo sd_emlrtRTEI = { 415,/* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo td_emlrtRTEI = { 538,/* lineNo */
  10,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ud_emlrtRTEI = { 416,/* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo vd_emlrtRTEI = { 410,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo wd_emlrtRTEI = { 538,/* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo xd_emlrtRTEI = { 416,/* lineNo */
  31,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo yd_emlrtRTEI = { 420,/* lineNo */
  13,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ae_emlrtRTEI = { 422,/* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo be_emlrtRTEI = { 422,/* lineNo */
  25,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ce_emlrtRTEI = { 424,/* lineNo */
  13,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo de_emlrtRTEI = { 426,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ee_emlrtRTEI = { 547,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo fe_emlrtRTEI = { 427,/* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ge_emlrtRTEI = { 427,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo he_emlrtRTEI = { 428,/* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ie_emlrtRTEI = { 558,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo je_emlrtRTEI = { 428,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ke_emlrtRTEI = { 560,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo le_emlrtRTEI = { 429,/* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo me_emlrtRTEI = { 429,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ne_emlrtRTEI = { 561,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo oe_emlrtRTEI = { 430,/* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo pe_emlrtRTEI = { 430,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo qe_emlrtRTEI = { 435,/* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo re_emlrtRTEI = { 435,/* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo se_emlrtRTEI = { 435,/* lineNo */
  32,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo te_emlrtRTEI = { 435,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ue_emlrtRTEI = { 439,/* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ve_emlrtRTEI = { 478,/* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo we_emlrtRTEI = { 441,/* lineNo */
  29,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo xe_emlrtRTEI = { 489,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ye_emlrtRTEI = { 490,/* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo af_emlrtRTEI = { 441,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo bf_emlrtRTEI = { 490,/* lineNo */
  26,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo cf_emlrtRTEI = { 118,/* lineNo */
  13,                                  /* colNo */
  "mtimes",                            /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\+blas\\mtimes.m"/* pName */
};

static emlrtRTEInfo df_emlrtRTEI = { 446,/* lineNo */
  20,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ef_emlrtRTEI = { 490,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ff_emlrtRTEI = { 453,/* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo gf_emlrtRTEI = { 447,/* lineNo */
  18,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo hf_emlrtRTEI = { 485,/* lineNo */
  34,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo if_emlrtRTEI = { 491,/* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo jf_emlrtRTEI = { 453,/* lineNo */
  27,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo kf_emlrtRTEI = { 455,/* lineNo */
  13,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo lf_emlrtRTEI = { 446,/* lineNo */
  13,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo mf_emlrtRTEI = { 491,/* lineNo */
  26,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo nf_emlrtRTEI = { 491,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo of_emlrtRTEI = { 458,/* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo pf_emlrtRTEI = { 458,/* lineNo */
  27,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo qf_emlrtRTEI = { 500,/* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo rf_emlrtRTEI = { 501,/* lineNo */
  24,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo sf_emlrtRTEI = { 517,/* lineNo */
  29,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo tf_emlrtRTEI = { 502,/* lineNo */
  24,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo uf_emlrtRTEI = { 517,/* lineNo */
  31,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo vf_emlrtRTEI = { 464,/* lineNo */
  31,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo wf_emlrtRTEI = { 503,/* lineNo */
  24,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo xf_emlrtRTEI = { 504,/* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo yf_emlrtRTEI = { 464,/* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ag_emlrtRTEI = { 505,/* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo bg_emlrtRTEI = { 506,/* lineNo */
  24,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo cg_emlrtRTEI = { 465,/* lineNo */
  25,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo dg_emlrtRTEI = { 507,/* lineNo */
  26,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo eg_emlrtRTEI = { 465,/* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo fg_emlrtRTEI = { 465,/* lineNo */
  46,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo gg_emlrtRTEI = { 465,/* lineNo */
  39,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo hg_emlrtRTEI = { 469,/* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ig_emlrtRTEI = { 470,/* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo jg_emlrtRTEI = { 470,/* lineNo */
  28,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo kg_emlrtRTEI = { 470,/* lineNo */
  59,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo lg_emlrtRTEI = { 470,/* lineNo */
  40,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo mg_emlrtRTEI = { 472,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ng_emlrtRTEI = { 86,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo og_emlrtRTEI = { 227,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo pg_emlrtRTEI = { 245,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo qg_emlrtRTEI = { 251,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo rg_emlrtRTEI = { 257,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo sg_emlrtRTEI = { 263,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo tg_emlrtRTEI = { 269,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ug_emlrtRTEI = { 275,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo vg_emlrtRTEI = { 281,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo wg_emlrtRTEI = { 287,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo xg_emlrtRTEI = { 293,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo yg_emlrtRTEI = { 299,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ah_emlrtRTEI = { 305,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo bh_emlrtRTEI = { 362,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo ch_emlrtRTEI = { 463,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo dh_emlrtRTEI = { 468,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo eh_emlrtRTEI = { 393,/* lineNo */
  55,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtRTEInfo fh_emlrtRTEI = { 33,/* lineNo */
  6,                                   /* colNo */
  "find",                              /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"/* pName */
};

static emlrtRTEInfo th_emlrtRTEI = { 83,/* lineNo */
  23,                                  /* colNo */
  "eml_mtimes_helper",                 /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"/* pName */
};

static emlrtRTEInfo uh_emlrtRTEI = { 88,/* lineNo */
  23,                                  /* colNo */
  "eml_mtimes_helper",                 /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"/* pName */
};

static emlrtRTEInfo vh_emlrtRTEI = { 281,/* lineNo */
  27,                                  /* colNo */
  "cat",                               /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\cat.m"/* pName */
};

static emlrtRTEInfo wh_emlrtRTEI = { 88,/* lineNo */
  9,                                   /* colNo */
  "indexShapeCheck",                   /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"/* pName */
};

static emlrtRTEInfo xh_emlrtRTEI = { 387,/* lineNo */
  1,                                   /* colNo */
  "find",                              /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"/* pName */
};

static emlrtRTEInfo yh_emlrtRTEI = { 77,/* lineNo */
  27,                                  /* colNo */
  "unaryMinOrMax",                     /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\unaryMinOrMax.m"/* pName */
};

static emlrtRTEInfo ai_emlrtRTEI = { 22,/* lineNo */
  27,                                  /* colNo */
  "unaryMinOrMax",                     /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\unaryMinOrMax.m"/* pName */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  470,                                 /* lineNo */
  59,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  470,                                 /* lineNo */
  28,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  469,                                 /* lineNo */
  33,                                  /* colNo */
  "x",                                 /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  465,                                 /* lineNo */
  46,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  465,                                 /* lineNo */
  16,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  464,                                 /* lineNo */
  33,                                  /* colNo */
  "x",                                 /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  485,                                 /* lineNo */
  38,                                  /* colNo */
  "t_r",                               /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  483,                                 /* lineNo */
  36,                                  /* colNo */
  "b",                                 /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  482,                                 /* lineNo */
  40,                                  /* colNo */
  "V_reset",                           /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  535,                                 /* lineNo */
  23,                                  /* colNo */
  "spikes",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  368,                                 /* lineNo */
  89,                                  /* colNo */
  "delta_T",                           /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  368,                                 /* lineNo */
  73,                                  /* colNo */
  "E_L",                               /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  368,                                 /* lineNo */
  63,                                  /* colNo */
  "V_reset",                           /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  368,                                 /* lineNo */
  26,                                  /* colNo */
  "b_w",                               /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  368,                                 /* lineNo */
  15,                                  /* colNo */
  "w_r",                               /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo emlrtECI = { -1,    /* nDims */
  517,                                 /* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo p_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  517,                                 /* lineNo */
  33,                                  /* colNo */
  "SimValues.WeightMat",               /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo b_emlrtECI = { -1,  /* nDims */
  507,                                 /* lineNo */
  10,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo q_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  507,                                 /* lineNo */
  28,                                  /* colNo */
  "SimValues.Input",                   /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo c_emlrtECI = { -1,  /* nDims */
  506,                                 /* lineNo */
  10,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo r_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  506,                                 /* lineNo */
  26,                                  /* colNo */
  "SimValues.a_w",                     /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo d_emlrtECI = { -1,  /* nDims */
  505,                                 /* lineNo */
  10,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo s_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  505,                                 /* lineNo */
  24,                                  /* colNo */
  "SimValues.w",                       /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo e_emlrtECI = { -1,  /* nDims */
  504,                                 /* lineNo */
  10,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo t_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  504,                                 /* lineNo */
  24,                                  /* colNo */
  "SimValues.s",                       /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo f_emlrtECI = { -1,  /* nDims */
  503,                                 /* lineNo */
  10,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo u_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  503,                                 /* lineNo */
  26,                                  /* colNo */
  "SimValues.g_i",                     /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo g_emlrtECI = { -1,  /* nDims */
  502,                                 /* lineNo */
  10,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo v_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  502,                                 /* lineNo */
  26,                                  /* colNo */
  "SimValues.g_e",                     /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo h_emlrtECI = { -1,  /* nDims */
  501,                                 /* lineNo */
  10,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo w_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  501,                                 /* lineNo */
  26,                                  /* colNo */
  "SimValues.g_w",                     /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo i_emlrtECI = { -1,  /* nDims */
  500,                                 /* lineNo */
  10,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo x_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  500,                                 /* lineNo */
  24,                                  /* colNo */
  "SimValues.V",                       /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo j_emlrtECI = { -1,  /* nDims */
  446,                                 /* lineNo */
  13,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo k_emlrtECI = { 2,   /* nDims */
  517,                                 /* lineNo */
  54,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo y_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  515,                                 /* lineNo */
  23,                                  /* colNo */
  "recordVALs",                        /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo l_emlrtECI = { -1,  /* nDims */
  507,                                 /* lineNo */
  53,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo ab_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  497,                                 /* lineNo */
  23,                                  /* colNo */
  "recordVALs",                        /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo m_emlrtECI = { -1,  /* nDims */
  491,                                 /* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo n_emlrtECI = { -1,  /* nDims */
  490,                                 /* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo o_emlrtECI = { -1,  /* nDims */
  489,                                 /* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo p_emlrtECI = { -1,  /* nDims */
  455,                                 /* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo q_emlrtECI = { 2,   /* nDims */
  472,                                 /* lineNo */
  18,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo r_emlrtECI = { -1,  /* nDims */
  470,                                 /* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo s_emlrtECI = { 1,   /* nDims */
  469,                                 /* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo t_emlrtECI = { 2,   /* nDims */
  469,                                 /* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo u_emlrtECI = { -1,  /* nDims */
  465,                                 /* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo v_emlrtECI = { 2,   /* nDims */
  464,                                 /* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo w_emlrtECI = { 1,   /* nDims */
  464,                                 /* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo x_emlrtECI = { -1,  /* nDims */
  464,                                 /* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo y_emlrtECI = { -1,  /* nDims */
  464,                                 /* lineNo */
  31,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo ab_emlrtECI = { -1, /* nDims */
  458,                                 /* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo bb_emlrtECI = { -1, /* nDims */
  453,                                 /* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtBCInfo bb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  445,                                 /* lineNo */
  23,                                  /* colNo */
  "recordVALs",                        /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo cb_emlrtECI = { -1, /* nDims */
  441,                                 /* lineNo */
  29,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo db_emlrtECI = { -1, /* nDims */
  439,                                 /* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo eb_emlrtECI = { -1, /* nDims */
  435,                                 /* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo fb_emlrtECI = { -1, /* nDims */
  435,                                 /* lineNo */
  36,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo gb_emlrtECI = { -1, /* nDims */
  435,                                 /* lineNo */
  37,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo hb_emlrtECI = { -1, /* nDims */
  430,                                 /* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo ib_emlrtECI = { -1, /* nDims */
  429,                                 /* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo jb_emlrtECI = { -1, /* nDims */
  428,                                 /* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo kb_emlrtECI = { -1, /* nDims */
  427,                                 /* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo lb_emlrtECI = { -1, /* nDims */
  426,                                 /* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo mb_emlrtECI = { -1, /* nDims */
  422,                                 /* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo nb_emlrtECI = { -1, /* nDims */
  422,                                 /* lineNo */
  25,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo ob_emlrtECI = { -1, /* nDims */
  414,                                 /* lineNo */
  14,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo pb_emlrtECI = { -1, /* nDims */
  416,                                 /* lineNo */
  31,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo qb_emlrtECI = { -1, /* nDims */
  416,                                 /* lineNo */
  37,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo rb_emlrtECI = { -1, /* nDims */
  416,                                 /* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo sb_emlrtECI = { -1, /* nDims */
  416,                                 /* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo tb_emlrtECI = { -1, /* nDims */
  415,                                 /* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo ub_emlrtECI = { -1, /* nDims */
  415,                                 /* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo vb_emlrtECI = { -1, /* nDims */
  414,                                 /* lineNo */
  22,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo wb_emlrtECI = { -1, /* nDims */
  393,                                 /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo xb_emlrtECI = { -1, /* nDims */
  410,                                 /* lineNo */
  14,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo yb_emlrtECI = { -1, /* nDims */
  410,                                 /* lineNo */
  32,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo ac_emlrtECI = { -1, /* nDims */
  368,                                 /* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo bc_emlrtECI = { -1, /* nDims */
  368,                                 /* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtDCInfo emlrtDCI = { 318,   /* lineNo */
  43,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtECInfo cc_emlrtECI = { 2,  /* nDims */
  163,                                 /* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo dc_emlrtECI = { -1, /* nDims */
  159,                                 /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo ec_emlrtECI = { -1, /* nDims */
  151,                                 /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo fc_emlrtECI = { -1, /* nDims */
  142,                                 /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtECInfo gc_emlrtECI = { -1, /* nDims */
  133,                                 /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pName */
};

static emlrtDCInfo b_emlrtDCI = { 109, /* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo c_emlrtDCI = { 108, /* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo d_emlrtDCI = { 107, /* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo e_emlrtDCI = { 106, /* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo f_emlrtDCI = { 106, /* lineNo */
  16,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  4                                    /* checkKind */
};

static emlrtDCInfo g_emlrtDCI = { 317, /* lineNo */
  48,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo h_emlrtDCI = { 348, /* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo i_emlrtDCI = { 349, /* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo j_emlrtDCI = { 350, /* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo k_emlrtDCI = { 351, /* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo l_emlrtDCI = { 352, /* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo m_emlrtDCI = { 353, /* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo n_emlrtDCI = { 354, /* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo o_emlrtDCI = { 355, /* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo p_emlrtDCI = { 357, /* lineNo */
  33,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo q_emlrtDCI = { 357, /* lineNo */
  40,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo r_emlrtDCI = { 364, /* lineNo */
  14,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo s_emlrtDCI = { 364, /* lineNo */
  14,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  4                                    /* checkKind */
};

static emlrtDCInfo t_emlrtDCI = { 133, /* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo cb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  133,                                 /* lineNo */
  12,                                  /* colNo */
  "EE_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo db_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  133,                                 /* lineNo */
  19,                                  /* colNo */
  "EE_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo eb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  135,                                 /* lineNo */
  5,                                   /* colNo */
  "EE_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo u_emlrtDCI = { 142, /* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo fb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  142,                                 /* lineNo */
  12,                                  /* colNo */
  "II_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  142,                                 /* lineNo */
  19,                                  /* colNo */
  "II_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  144,                                 /* lineNo */
  5,                                   /* colNo */
  "II_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ib_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  151,                                 /* lineNo */
  12,                                  /* colNo */
  "IE_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  151,                                 /* lineNo */
  19,                                  /* colNo */
  "IE_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  159,                                 /* lineNo */
  12,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  159,                                 /* lineNo */
  19,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo v_emlrtDCI = { 209, /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo w_emlrtDCI = { 209, /* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  4                                    /* checkKind */
};

static emlrtDCInfo x_emlrtDCI = { 209, /* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo y_emlrtDCI = { 209, /* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  4                                    /* checkKind */
};

static emlrtDCInfo ab_emlrtDCI = { 215,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo bb_emlrtDCI = { 215,/* lineNo */
  11,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo cb_emlrtDCI = { 221,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo db_emlrtDCI = { 221,/* lineNo */
  9,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo eb_emlrtDCI = { 229,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo fb_emlrtDCI = { 233,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo gb_emlrtDCI = { 233,/* lineNo */
  12,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo hb_emlrtDCI = { 239,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo ib_emlrtDCI = { 239,/* lineNo */
  15,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo jb_emlrtDCI = { 247,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo kb_emlrtDCI = { 253,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo lb_emlrtDCI = { 259,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo mb_emlrtDCI = { 265,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo nb_emlrtDCI = { 271,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo ob_emlrtDCI = { 277,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo pb_emlrtDCI = { 283,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo qb_emlrtDCI = { 289,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo rb_emlrtDCI = { 295,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo sb_emlrtDCI = { 301,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo tb_emlrtDCI = { 307,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo ub_emlrtDCI = { 311,/* lineNo */
  5,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo vb_emlrtDCI = { 311,/* lineNo */
  13,                                  /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo wb_emlrtDCI = { 316,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo xb_emlrtDCI = { 317,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo yb_emlrtDCI = { 319,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo ac_emlrtDCI = { 321,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo bc_emlrtDCI = { 334,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo cc_emlrtDCI = { 335,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo dc_emlrtDCI = { 336,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo ec_emlrtDCI = { 337,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo fc_emlrtDCI = { 338,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo gc_emlrtDCI = { 339,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo hc_emlrtDCI = { 340,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo ic_emlrtDCI = { 341,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo jc_emlrtDCI = { 342,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo kc_emlrtDCI = { 344,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo lc_emlrtDCI = { 348,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo mc_emlrtDCI = { 349,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo nc_emlrtDCI = { 350,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo oc_emlrtDCI = { 351,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo pc_emlrtDCI = { 352,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo qc_emlrtDCI = { 353,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo rc_emlrtDCI = { 354,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo sc_emlrtDCI = { 355,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo tc_emlrtDCI = { 357,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo uc_emlrtDCI = { 364,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo vc_emlrtDCI = { 364,/* lineNo */
  1,                                   /* colNo */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  4                                    /* checkKind */
};

static emlrtBCInfo mb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  368,                                 /* lineNo */
  42,                                  /* colNo */
  "w_r",                               /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  368,                                 /* lineNo */
  1,                                   /* colNo */
  "b",                                 /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ob_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  446,                                 /* lineNo */
  20,                                  /* colNo */
  "spikes",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  453,                                 /* lineNo */
  11,                                  /* colNo */
  "s",                                 /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  453,                                 /* lineNo */
  29,                                  /* colNo */
  "s",                                 /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  455,                                 /* lineNo */
  13,                                  /* colNo */
  "t_r",                               /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  455,                                 /* lineNo */
  35,                                  /* colNo */
  "t_ref",                             /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo tb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  458,                                 /* lineNo */
  11,                                  /* colNo */
  "x",                                 /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ub_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  458,                                 /* lineNo */
  29,                                  /* colNo */
  "x",                                 /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  463,                                 /* lineNo */
  22,                                  /* colNo */
  "spikeneurons",                      /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  465,                                 /* lineNo */
  25,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  465,                                 /* lineNo */
  55,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  468,                                 /* lineNo */
  23,                                  /* colNo */
  "spikeneurons",                      /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ac_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  470,                                 /* lineNo */
  16,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  470,                                 /* lineNo */
  47,                                  /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  473,                                 /* lineNo */
  9,                                   /* colNo */
  "EI_mat",                            /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  482,                                 /* lineNo */
  9,                                   /* colNo */
  "V",                                 /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ec_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  483,                                 /* lineNo */
  9,                                   /* colNo */
  "a_w",                               /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  485,                                 /* lineNo */
  9,                                   /* colNo */
  "t_r",                               /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  499,                                 /* lineNo */
  10,                                  /* colNo */
  "SimValues.t",                       /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  516,                                 /* lineNo */
  9,                                   /* colNo */
  "SimValues.t_weight",                /* aName */
  "CAdLIFfunction_STDP",               /* fName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRSInfo bd_emlrtRSI = { 537,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo cd_emlrtRSI = { 538,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo dd_emlrtRSI = { 539,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo ed_emlrtRSI = { 540,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo fd_emlrtRSI = { 541,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

static emlrtRSInfo gd_emlrtRSI = { 542,/* lineNo */
  "CAdLIFfunction_STDP",               /* fcnName */
  "C:\\Users\\jgorn\\OneDrive\\Documents\\GitHub\\SOSpikingModel\\AnalysisScripts\\CAdLIFfunction_STDP.m"/* pathName */
};

/* Function Declarations */
static const mxArray *b_emlrt_marshallOut(const real_T u[2]);
static void b_plot(const emlrtStack *sp, const mxArray *b, const mxArray *c,
                   const mxArray *d, emlrtMCInfo *location);
static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u);
static void figure(const emlrtStack *sp, emlrtMCInfo *location);
static void hold(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);
static void plot(const emlrtStack *sp, const mxArray *b, const mxArray *c, const
                 mxArray *d, const mxArray *e, const mxArray *f, emlrtMCInfo
                 *location);
static void title(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);
static void xlabel(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);
static void xlim(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);
static void ylabel(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);
static void ylim(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);

/* Function Definitions */
static const mxArray *b_emlrt_marshallOut(const real_T u[2])
{
  const mxArray *y;
  const mxArray *m2;
  static const int32_T iv7[2] = { 1, 2 };

  real_T *pData;
  int32_T i7;
  int32_T i;
  y = NULL;
  m2 = emlrtCreateNumericArray(2, iv7, mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m2);
  i7 = 0;
  for (i = 0; i < 2; i++) {
    pData[i7] = u[i];
    i7++;
  }

  emlrtAssign(&y, m2);
  return y;
}

static void b_plot(const emlrtStack *sp, const mxArray *b, const mxArray *c,
                   const mxArray *d, emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  pArrays[0] = b;
  pArrays[1] = c;
  pArrays[2] = d;
  emlrtCallMATLABR2012b(sp, 0, NULL, 3, pArrays, "plot", true, location);
}

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u)
{
  const mxArray *y;
  const mxArray *m1;
  real32_T *pData;
  int32_T i6;
  int32_T i;
  y = NULL;
  m1 = emlrtCreateNumericArray(1, *(int32_T (*)[1])u->size, mxSINGLE_CLASS,
    mxREAL);
  pData = (real32_T *)emlrtMxGetData(m1);
  i6 = 0;
  for (i = 0; i < u->size[0]; i++) {
    pData[i6] = u->data[i];
    i6++;
  }

  emlrtAssign(&y, m1);
  return y;
}

static void figure(const emlrtStack *sp, emlrtMCInfo *location)
{
  emlrtCallMATLABR2012b(sp, 0, NULL, 0, NULL, "figure", true, location);
}

static void hold(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "hold", true, location);
}

static void plot(const emlrtStack *sp, const mxArray *b, const mxArray *c, const
                 mxArray *d, const mxArray *e, const mxArray *f, emlrtMCInfo
                 *location)
{
  const mxArray *pArrays[5];
  pArrays[0] = b;
  pArrays[1] = c;
  pArrays[2] = d;
  pArrays[3] = e;
  pArrays[4] = f;
  emlrtCallMATLABR2012b(sp, 0, NULL, 5, pArrays, "plot", true, location);
}

static void title(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "title", true, location);
}

static void xlabel(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "xlabel", true, location);
}

static void xlim(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "xlim", true, location);
}

static void ylabel(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "ylabel", true, location);
}

static void ylim(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "ylim", true, location);
}

void CAdLIFfunction_STDP(const emlrtStack *sp, const struct0_T *PopParams, const
  struct1_T *TimeParams, struct2_T *SimValues)
{
  emxArray_real_T *recordVALs;
  real_T dv0[4];
  real_T EPopNum;
  real_T PopNum;
  real_T dt;
  emxArray_real_T *r0;
  int32_T i0;
  real_T ndbl;
  int32_T varargin_2;
  real_T apnd;
  emxArray_real_T *r1;
  real_T cdiff;
  int32_T loop_ub;
  int32_T idx;
  emxArray_real_T *r2;
  emxArray_real_T *EE_mat;
  int32_T nm1d2;
  int32_T nx;
  emxArray_real_T *II_mat;
  emxArray_real_T *IE_mat;
  emxArray_real_T *EI_mat;
  emxArray_real_T *Ecells;
  emxArray_real_T *ILearningRate;
  emxArray_boolean_T *EcellIDX;
  emxArray_real_T *Icells;
  real_T absa;
  emxArray_boolean_T *IcellIDX;
  emxArray_int32_T *ii;
  emxArray_int32_T *r3;
  emxArray_real_T *b_EI_mat;
  int32_T b_ii[2];
  emxArray_boolean_T *isconnected;
  real_T V0range[2];
  emxArray_boolean_T *x;
  emxArray_int32_T *r4;
  emxArray_int32_T *r5;
  int32_T b_EE_mat[2];
  int32_T c_EI_mat[2];
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
  emxArray_real_T *b_x;
  emxArray_boolean_T *c_x;
  emxArray_int32_T *c_ii;
  boolean_T overflow;
  boolean_T exitg1;
  emxArray_real32_T *spikes;
  emxArray_int32_T *r6;
  emxArray_real_T *b_w_r;
  emxArray_real_T *r7;
  emxArray_real_T *r8;
  emxArray_int32_T *r9;
  emxArray_real_T *r10;
  emxArray_real_T *dX;
  int32_T d_ii[1];
  uint32_T savecounter;
  uint32_T weightcounter;
  int32_T tt;
  emxArray_real_T *PreIspikes;
  emxArray_real_T *PostEspikes;
  emxArray_real32_T *r11;
  emxArray_int32_T *r12;
  emxArray_int32_T *r13;
  emxArray_int32_T *r14;
  emxArray_int32_T *r15;
  emxArray_int32_T *r16;
  emxArray_int32_T *r17;
  emxArray_int32_T *r18;
  emxArray_int32_T *r19;
  emxArray_int32_T *r20;
  emxArray_int32_T *r21;
  emxArray_int32_T *r22;
  emxArray_boolean_T *b_sigma;
  const mxArray *y;
  const mxArray *m0;
  emxArray_real32_T *b_spikes;
  static const int32_T iv0[2] = { 1, 2 };

  static const char_T u[2] = { 'k', '.' };

  const mxArray *b_y;
  static const int32_T iv1[2] = { 1, 10 };

  static const char_T b_u[10] = { 'M', 'a', 'r', 'k', 'e', 'r', 's', 'i', 'z',
    'e' };

  const mxArray *c_y;
  emxArray_real32_T *c_spikes;
  static const int32_T iv2[2] = { 1, 2 };

  static const char_T c_u[2] = { 'o', 'n' };

  real_T dv1[2];
  static const int32_T iv3[2] = { 1, 9 };

  static const char_T d_u[9] = { 'T', 'i', 'm', 'e', ' ', '(', 'm', 's', ')' };

  static const int32_T iv4[2] = { 1, 9 };

  static const char_T e_u[9] = { 'N', 'e', 'u', 'r', 'o', 'n', ' ', 'I', 'D' };

  static const int32_T iv5[2] = { 1, 11 };

  static const char_T f_u[11] = { 'R', 'a', 's', 't', 'e', 'r', ' ', 'P', 'l',
    'o', 't' };

  char_T TRANSA;
  char_T TRANSB;
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  int32_T iv6[1];
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  emlrtStack h_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  f_st.prev = &e_st;
  f_st.tls = e_st.tls;
  g_st.prev = &f_st;
  g_st.tls = f_st.tls;
  h_st.prev = &g_st;
  h_st.tls = g_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T(sp, &recordVALs, 2, &ng_emlrtRTEI, true);

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
  dv0[0] = 0.0;
  dv0[2] = TimeParams->SimTime - 1000.0;
  dv0[1] = 1000.0;
  dv0[3] = TimeParams->SimTime;
  st.site = &emlrtRSI;
  createRecorder(&st, dv0, TimeParams->dt, TimeParams->SimTime, recordVALs);

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
  st.site = &b_emlrtRSI;
  emxInit_real_T(&st, &r0, 2, &t_emlrtRTEI, true);
  if (muDoubleScalarIsNaN(TimeParams->dt) || muDoubleScalarIsNaN
      (TimeParams->SimTime)) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[1] = 1;
    emxEnsureCapacity_real_T(&st, r0, i0, &b_emlrtRTEI);
  } else if ((TimeParams->dt == 0.0) || ((-0.0 < TimeParams->SimTime) &&
              (TimeParams->dt < 0.0)) || ((TimeParams->SimTime < -0.0) &&
              (TimeParams->dt > 0.0))) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[1] = 0;
    emxEnsureCapacity_real_T(&st, r0, i0, &b_emlrtRTEI);
  } else if (muDoubleScalarIsInf(TimeParams->SimTime) && (muDoubleScalarIsInf
              (TimeParams->dt) || (-0.0 == TimeParams->SimTime))) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[1] = 1;
    emxEnsureCapacity_real_T(&st, r0, i0, &b_emlrtRTEI);
  } else if (muDoubleScalarIsInf(TimeParams->dt)) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[1] = 1;
    emxEnsureCapacity_real_T(&st, r0, i0, &b_emlrtRTEI);
  } else if (muDoubleScalarFloor(TimeParams->dt) == TimeParams->dt) {
    i0 = r0->size[0] * r0->size[1];
    r0->size[0] = 1;
    r0->size[1] = (int32_T)muDoubleScalarFloor(TimeParams->SimTime /
      TimeParams->dt) + 1;
    emxEnsureCapacity_real_T(&st, r0, i0, &b_emlrtRTEI);
    loop_ub = (int32_T)muDoubleScalarFloor(TimeParams->SimTime / TimeParams->dt);
    for (i0 = 0; i0 <= loop_ub; i0++) {
      r0->data[r0->size[0] * i0] = TimeParams->dt * (real_T)i0;
    }
  } else {
    b_st.site = &hb_emlrtRSI;
    ndbl = muDoubleScalarFloor(TimeParams->SimTime / TimeParams->dt + 0.5);
    apnd = ndbl * TimeParams->dt;
    if (TimeParams->dt > 0.0) {
      cdiff = apnd - TimeParams->SimTime;
    } else {
      cdiff = TimeParams->SimTime - apnd;
    }

    if (muDoubleScalarAbs(cdiff) < 4.4408920985006262E-16 * muDoubleScalarAbs
        (TimeParams->SimTime)) {
      ndbl++;
      apnd = TimeParams->SimTime;
    } else if (cdiff > 0.0) {
      apnd = (ndbl - 1.0) * TimeParams->dt;
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      idx = (int32_T)ndbl;
    } else {
      idx = 0;
    }

    c_st.site = &ib_emlrtRSI;
    if (ndbl > 2.147483647E+9) {
      emlrtErrorWithMessageIdR2018a(&c_st, &bi_emlrtRTEI,
        "Coder:MATLAB:pmaxsize", "Coder:MATLAB:pmaxsize", 0);
    }

    i0 = r0->size[0] * r0->size[1];
    r0->size[0] = 1;
    r0->size[1] = idx;
    emxEnsureCapacity_real_T(&b_st, r0, i0, &f_emlrtRTEI);
    if (idx > 0) {
      r0->data[0] = -0.0;
      if (idx > 1) {
        r0->data[idx - 1] = apnd;
        nm1d2 = (idx - 1) / 2;
        c_st.site = &jb_emlrtRSI;
        for (nx = 1; nx < nm1d2; nx++) {
          ndbl = (real_T)nx * dt;
          r0->data[nx] = ndbl;
          r0->data[(idx - nx) - 1] = apnd - ndbl;
        }

        if (nm1d2 << 1 == idx - 1) {
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
  emxInit_real_T(sp, &r1, 2, &t_emlrtRTEI, true);
  if (muDoubleScalarIsNaN(TimeParams->SimTime)) {
    i0 = r1->size[0] * r1->size[1];
    r1->size[0] = 1;
    r1->size[1] = 1;
    emxEnsureCapacity_real_T(sp, r1, i0, &c_emlrtRTEI);
    r1->data[0] = rtNaN;
  } else if (TimeParams->SimTime < 0.0) {
    i0 = r1->size[0] * r1->size[1];
    r1->size[0] = 1;
    r1->size[1] = 0;
    emxEnsureCapacity_real_T(sp, r1, i0, &c_emlrtRTEI);
  } else if (muDoubleScalarIsInf(TimeParams->SimTime) && (0.0 ==
              TimeParams->SimTime)) {
    i0 = r1->size[0] * r1->size[1];
    r1->size[0] = 1;
    r1->size[1] = 1;
    emxEnsureCapacity_real_T(sp, r1, i0, &c_emlrtRTEI);
    r1->data[0] = rtNaN;
  } else {
    i0 = r1->size[0] * r1->size[1];
    r1->size[0] = 1;
    r1->size[1] = (int32_T)muDoubleScalarFloor(TimeParams->SimTime) + 1;
    emxEnsureCapacity_real_T(sp, r1, i0, &c_emlrtRTEI);
    loop_ub = (int32_T)muDoubleScalarFloor(TimeParams->SimTime);
    for (i0 = 0; i0 <= loop_ub; i0++) {
      r1->data[r1->size[0] * i0] = i0;
    }
  }

  /* Time Steps (saved) */
  emxInit_real_T(sp, &r2, 2, &t_emlrtRTEI, true);
  if (muDoubleScalarIsNaN(TimeParams->SimTime)) {
    i0 = r2->size[0] * r2->size[1];
    r2->size[1] = 1;
    emxEnsureCapacity_real_T(sp, r2, i0, &d_emlrtRTEI);
  } else if (TimeParams->SimTime < 0.0) {
    i0 = r2->size[0] * r2->size[1];
    r2->size[1] = 0;
    emxEnsureCapacity_real_T(sp, r2, i0, &d_emlrtRTEI);
  } else if (muDoubleScalarIsInf(TimeParams->SimTime) && (0.0 ==
              TimeParams->SimTime)) {
    i0 = r2->size[0] * r2->size[1];
    r2->size[1] = 1;
    emxEnsureCapacity_real_T(sp, r2, i0, &d_emlrtRTEI);
  } else {
    i0 = r2->size[0] * r2->size[1];
    r2->size[0] = 1;
    r2->size[1] = (int32_T)muDoubleScalarFloor(TimeParams->SimTime / 10.0) + 1;
    emxEnsureCapacity_real_T(sp, r2, i0, &d_emlrtRTEI);
    loop_ub = (int32_T)muDoubleScalarFloor(TimeParams->SimTime / 10.0);
    for (i0 = 0; i0 <= loop_ub; i0++) {
      r2->data[r2->size[0] * i0] = 10.0 * (real_T)i0;
    }
  }

  emxInit_real_T(sp, &EE_mat, 2, &e_emlrtRTEI, true);

  /* Time Steps (saved) */
  /* -------------------------------------------------------------------------- */
  /* Weight Matrices */
  if (!(PopNum >= 0.0)) {
    emlrtNonNegativeCheckR2012b(PopNum, &f_emlrtDCI, sp);
  }

  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &e_emlrtDCI, sp);
  }

  i0 = EE_mat->size[0] * EE_mat->size[1];
  EE_mat->size[0] = (int32_T)PopNum;
  EE_mat->size[1] = (int32_T)PopNum;
  emxEnsureCapacity_real_T(sp, EE_mat, i0, &e_emlrtRTEI);
  loop_ub = (int32_T)PopNum * (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    EE_mat->data[i0] = 0.0;
  }

  emxInit_real_T(sp, &II_mat, 2, &g_emlrtRTEI, true);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &d_emlrtDCI, sp);
  }

  i0 = II_mat->size[0] * II_mat->size[1];
  II_mat->size[0] = (int32_T)PopNum;
  II_mat->size[1] = (int32_T)PopNum;
  emxEnsureCapacity_real_T(sp, II_mat, i0, &g_emlrtRTEI);
  loop_ub = (int32_T)PopNum * (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    II_mat->data[i0] = 0.0;
  }

  emxInit_real_T(sp, &IE_mat, 2, &h_emlrtRTEI, true);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &c_emlrtDCI, sp);
  }

  i0 = IE_mat->size[0] * IE_mat->size[1];
  IE_mat->size[0] = (int32_T)PopNum;
  IE_mat->size[1] = (int32_T)PopNum;
  emxEnsureCapacity_real_T(sp, IE_mat, i0, &h_emlrtRTEI);
  loop_ub = (int32_T)PopNum * (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    IE_mat->data[i0] = 0.0;
  }

  emxInit_real_T(sp, &EI_mat, 2, &i_emlrtRTEI, true);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &b_emlrtDCI, sp);
  }

  i0 = EI_mat->size[0] * EI_mat->size[1];
  EI_mat->size[0] = (int32_T)PopNum;
  EI_mat->size[1] = (int32_T)PopNum;
  emxEnsureCapacity_real_T(sp, EI_mat, i0, &i_emlrtRTEI);
  loop_ub = (int32_T)PopNum * (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    EI_mat->data[i0] = 0.0;
  }

  emxInit_real_T(sp, &Ecells, 2, &j_emlrtRTEI, true);
  if (muDoubleScalarIsNaN(PopParams->EPopNum)) {
    i0 = Ecells->size[0] * Ecells->size[1];
    Ecells->size[0] = 1;
    Ecells->size[1] = 1;
    emxEnsureCapacity_real_T(sp, Ecells, i0, &j_emlrtRTEI);
    Ecells->data[0] = rtNaN;
  } else if (PopParams->EPopNum < 1.0) {
    i0 = Ecells->size[0] * Ecells->size[1];
    Ecells->size[0] = 1;
    Ecells->size[1] = 0;
    emxEnsureCapacity_real_T(sp, Ecells, i0, &j_emlrtRTEI);
  } else if (muDoubleScalarIsInf(PopParams->EPopNum) && (1.0 ==
              PopParams->EPopNum)) {
    i0 = Ecells->size[0] * Ecells->size[1];
    Ecells->size[0] = 1;
    Ecells->size[1] = 1;
    emxEnsureCapacity_real_T(sp, Ecells, i0, &j_emlrtRTEI);
    Ecells->data[0] = rtNaN;
  } else {
    i0 = Ecells->size[0] * Ecells->size[1];
    Ecells->size[0] = 1;
    Ecells->size[1] = (int32_T)muDoubleScalarFloor(PopParams->EPopNum - 1.0) + 1;
    emxEnsureCapacity_real_T(sp, Ecells, i0, &j_emlrtRTEI);
    loop_ub = (int32_T)muDoubleScalarFloor(PopParams->EPopNum - 1.0);
    for (i0 = 0; i0 <= loop_ub; i0++) {
      Ecells->data[Ecells->size[0] * i0] = 1.0 + (real_T)i0;
    }
  }

  emxInit_real_T(sp, &ILearningRate, 2, &dc_emlrtRTEI, true);
  if (PopNum < 1.0) {
    i0 = ILearningRate->size[0] * ILearningRate->size[1];
    ILearningRate->size[0] = 1;
    ILearningRate->size[1] = 0;
    emxEnsureCapacity_real_T(sp, ILearningRate, i0, &k_emlrtRTEI);
  } else if (muDoubleScalarIsInf(PopNum) && (1.0 == PopNum)) {
    i0 = ILearningRate->size[0] * ILearningRate->size[1];
    ILearningRate->size[0] = 1;
    ILearningRate->size[1] = 1;
    emxEnsureCapacity_real_T(sp, ILearningRate, i0, &k_emlrtRTEI);
    ILearningRate->data[0] = rtNaN;
  } else {
    i0 = ILearningRate->size[0] * ILearningRate->size[1];
    ILearningRate->size[0] = 1;
    ILearningRate->size[1] = (int32_T)muDoubleScalarFloor(PopNum - 1.0) + 1;
    emxEnsureCapacity_real_T(sp, ILearningRate, i0, &k_emlrtRTEI);
    loop_ub = (int32_T)muDoubleScalarFloor(PopNum - 1.0);
    for (i0 = 0; i0 <= loop_ub; i0++) {
      ILearningRate->data[ILearningRate->size[0] * i0] = 1.0 + (real_T)i0;
    }
  }

  emxInit_boolean_T(sp, &EcellIDX, 2, &l_emlrtRTEI, true);
  i0 = EcellIDX->size[0] * EcellIDX->size[1];
  EcellIDX->size[0] = 1;
  EcellIDX->size[1] = ILearningRate->size[1];
  emxEnsureCapacity_boolean_T(sp, EcellIDX, i0, &l_emlrtRTEI);
  loop_ub = ILearningRate->size[0] * ILearningRate->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    EcellIDX->data[i0] = (ILearningRate->data[i0] <= PopParams->EPopNum);
  }

  /* EcellIDX = ismember(1:PopNum,Ecells); */
  st.site = &c_emlrtRSI;
  b_st.site = &lb_emlrtRSI;
  emxInit_real_T(&b_st, &Icells, 2, &m_emlrtRTEI, true);
  if (muDoubleScalarIsNaN(PopParams->EPopNum + 1.0)) {
    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = 1;
    emxEnsureCapacity_real_T(&b_st, Icells, i0, &m_emlrtRTEI);
    Icells->data[0] = rtNaN;
  } else if (PopNum < PopParams->EPopNum + 1.0) {
    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = 0;
    emxEnsureCapacity_real_T(&b_st, Icells, i0, &m_emlrtRTEI);
  } else if ((muDoubleScalarIsInf(PopParams->EPopNum + 1.0) ||
              muDoubleScalarIsInf(PopNum)) && (PopParams->EPopNum + 1.0 ==
              PopNum)) {
    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = 1;
    emxEnsureCapacity_real_T(&b_st, Icells, i0, &m_emlrtRTEI);
    Icells->data[0] = rtNaN;
  } else if (muDoubleScalarFloor(PopParams->EPopNum + 1.0) == PopParams->EPopNum
             + 1.0) {
    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = (int32_T)muDoubleScalarFloor(PopNum - (PopParams->EPopNum
      + 1.0)) + 1;
    emxEnsureCapacity_real_T(&b_st, Icells, i0, &m_emlrtRTEI);
    loop_ub = (int32_T)muDoubleScalarFloor(PopNum - (PopParams->EPopNum + 1.0));
    for (i0 = 0; i0 <= loop_ub; i0++) {
      Icells->data[Icells->size[0] * i0] = (PopParams->EPopNum + 1.0) + (real_T)
        i0;
    }
  } else {
    c_st.site = &hb_emlrtRSI;
    ndbl = muDoubleScalarFloor((PopNum - (PopParams->EPopNum + 1.0)) + 0.5);
    apnd = (PopParams->EPopNum + 1.0) + ndbl;
    cdiff = apnd - PopNum;
    absa = muDoubleScalarAbs(PopParams->EPopNum + 1.0);
    if (muDoubleScalarAbs(cdiff) < 4.4408920985006262E-16 * muDoubleScalarMax
        (absa, PopNum)) {
      ndbl++;
      apnd = PopNum;
    } else if (cdiff > 0.0) {
      apnd = (PopParams->EPopNum + 1.0) + (ndbl - 1.0);
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      idx = (int32_T)ndbl;
    } else {
      idx = 0;
    }

    d_st.site = &ib_emlrtRSI;
    if (ndbl > 2.147483647E+9) {
      emlrtErrorWithMessageIdR2018a(&d_st, &bi_emlrtRTEI,
        "Coder:MATLAB:pmaxsize", "Coder:MATLAB:pmaxsize", 0);
    }

    i0 = Icells->size[0] * Icells->size[1];
    Icells->size[0] = 1;
    Icells->size[1] = idx;
    emxEnsureCapacity_real_T(&c_st, Icells, i0, &f_emlrtRTEI);
    if (idx > 0) {
      Icells->data[0] = PopParams->EPopNum + 1.0;
      if (idx > 1) {
        Icells->data[idx - 1] = apnd;
        nm1d2 = (idx - 1) / 2;
        d_st.site = &jb_emlrtRSI;
        for (nx = 1; nx < nm1d2; nx++) {
          Icells->data[nx] = (EPopNum + 1.0) + (real_T)nx;
          Icells->data[(idx - nx) - 1] = apnd - (real_T)nx;
        }

        if (nm1d2 << 1 == idx - 1) {
          Icells->data[nm1d2] = ((PopParams->EPopNum + 1.0) + apnd) / 2.0;
        } else {
          Icells->data[nm1d2] = (PopParams->EPopNum + 1.0) + (real_T)nm1d2;
          Icells->data[nm1d2 + 1] = apnd - (real_T)nm1d2;
        }
      }
    }
  }

  if (PopNum < 1.0) {
    i0 = ILearningRate->size[0] * ILearningRate->size[1];
    ILearningRate->size[0] = 1;
    ILearningRate->size[1] = 0;
    emxEnsureCapacity_real_T(sp, ILearningRate, i0, &k_emlrtRTEI);
  } else if (muDoubleScalarIsInf(PopNum) && (1.0 == PopNum)) {
    i0 = ILearningRate->size[0] * ILearningRate->size[1];
    ILearningRate->size[0] = 1;
    ILearningRate->size[1] = 1;
    emxEnsureCapacity_real_T(sp, ILearningRate, i0, &k_emlrtRTEI);
    ILearningRate->data[0] = rtNaN;
  } else {
    i0 = ILearningRate->size[0] * ILearningRate->size[1];
    ILearningRate->size[0] = 1;
    ILearningRate->size[1] = (int32_T)muDoubleScalarFloor(PopNum - 1.0) + 1;
    emxEnsureCapacity_real_T(sp, ILearningRate, i0, &k_emlrtRTEI);
    loop_ub = (int32_T)muDoubleScalarFloor(PopNum - 1.0);
    for (i0 = 0; i0 <= loop_ub; i0++) {
      ILearningRate->data[ILearningRate->size[0] * i0] = 1.0 + (real_T)i0;
    }
  }

  emxInit_boolean_T(sp, &IcellIDX, 2, &n_emlrtRTEI, true);
  i0 = IcellIDX->size[0] * IcellIDX->size[1];
  IcellIDX->size[0] = 1;
  IcellIDX->size[1] = ILearningRate->size[1];
  emxEnsureCapacity_boolean_T(sp, IcellIDX, i0, &n_emlrtRTEI);
  loop_ub = ILearningRate->size[0] * ILearningRate->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    IcellIDX->data[i0] = (ILearningRate->data[i0] > PopParams->EPopNum);
  }

  emxInit_int32_T(sp, &ii, 1, &fh_emlrtRTEI, true);

  /* IcellIDX = ismember(1:PopNum,Icells); */
  /* Here we assign four 2x2 matrices of matrix (tensor?). There are positive values on the locations where there are connections. */
  /* For example, there are values for the EE connections on the 1x1 matrix, II */
  /* on the 2x2 matrix, and etc (this is based on the indexing of the neuron population).  */
  /* NOTE: presynaptic neurons are columns (dim2) and postsynaptic neurons are rows (dim1). */
  /* E->E Synapses */
  ndbl = PopParams->Kee / (PopParams->EPopNum - 1.0);

  /* -1 to account for self-connections (which are then removed) */
  i0 = ii->size[0];
  ii->size[0] = Ecells->size[1];
  emxEnsureCapacity_int32_T(sp, ii, i0, &o_emlrtRTEI);
  loop_ub = Ecells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    apnd = Ecells->data[Ecells->size[0] * i0];
    if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
      emlrtIntegerCheckR2012b(apnd, &t_emlrtDCI, sp);
    }

    idx = (int32_T)PopNum;
    nm1d2 = (int32_T)apnd;
    if (!((nm1d2 >= 1) && (nm1d2 <= idx))) {
      emlrtDynamicBoundsCheckR2012b(nm1d2, 1, idx, &cb_emlrtBCI, sp);
    }

    ii->data[i0] = nm1d2 - 1;
  }

  emxInit_int32_T(sp, &r3, 1, &t_emlrtRTEI, true);
  i0 = r3->size[0];
  r3->size[0] = Ecells->size[1];
  emxEnsureCapacity_int32_T(sp, r3, i0, &p_emlrtRTEI);
  loop_ub = Ecells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    idx = (int32_T)PopNum;
    nm1d2 = (int32_T)Ecells->data[Ecells->size[0] * i0];
    if (!((nm1d2 >= 1) && (nm1d2 <= idx))) {
      emlrtDynamicBoundsCheckR2012b(nm1d2, 1, idx, &db_emlrtBCI, sp);
    }

    r3->data[i0] = nm1d2 - 1;
  }

  emxInit_real_T(sp, &b_EI_mat, 2, &gg_emlrtRTEI, true);
  st.site = &d_emlrtRSI;
  b_rand(&st, PopParams->EPopNum, b_EI_mat);
  loop_ub = b_EI_mat->size[0] * b_EI_mat->size[1] - 1;
  i0 = b_EI_mat->size[0] * b_EI_mat->size[1];
  emxEnsureCapacity_real_T(sp, b_EI_mat, i0, &q_emlrtRTEI);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    b_EI_mat->data[i0] = (b_EI_mat->data[i0] <= ndbl);
  }

  b_ii[0] = ii->size[0];
  b_ii[1] = r3->size[0];
  emlrtSubAssignSizeCheckR2012b(&b_ii[0], 2, &(*(int32_T (*)[2])b_EI_mat->size)
    [0], 2, &gc_emlrtECI, sp);
  loop_ub = b_EI_mat->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    nm1d2 = b_EI_mat->size[0];
    for (idx = 0; idx < nm1d2; idx++) {
      EE_mat->data[ii->data[idx] + EE_mat->size[0] * r3->data[i0]] =
        b_EI_mat->data[idx + b_EI_mat->size[0] * i0];
    }
  }

  loop_ub = EE_mat->size[0] * EE_mat->size[1] - 1;
  i0 = EE_mat->size[0] * EE_mat->size[1];
  emxEnsureCapacity_real_T(sp, EE_mat, i0, &r_emlrtRTEI);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    EE_mat->data[i0] *= PopParams->Wee;
  }

  for (i0 = 0; i0 < 2; i0++) {
    V0range[i0] = EE_mat->size[i0];
  }

  emxInit_boolean_T(sp, &isconnected, 2, &ib_emlrtRTEI, true);
  i0 = isconnected->size[0] * isconnected->size[1];
  isconnected->size[0] = (int32_T)V0range[0];
  emxEnsureCapacity_boolean_T(sp, isconnected, i0, &s_emlrtRTEI);
  i0 = isconnected->size[0] * isconnected->size[1];
  isconnected->size[1] = (int32_T)V0range[1];
  emxEnsureCapacity_boolean_T(sp, isconnected, i0, &s_emlrtRTEI);
  loop_ub = (int32_T)V0range[0] * (int32_T)V0range[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    isconnected->data[i0] = true;
  }

  emxInit_boolean_T1(sp, &x, 1, &we_emlrtRTEI, true);
  st.site = &e_emlrtRSI;
  diag(&st, isconnected, x);
  st.site = &e_emlrtRSI;
  b_diag(&st, x, isconnected);
  nx = isconnected->size[0] * isconnected->size[1] - 1;
  nm1d2 = 0;
  for (idx = 0; idx <= nx; idx++) {
    if (isconnected->data[idx]) {
      nm1d2++;
    }
  }

  emxInit_int32_T(sp, &r4, 1, &vf_emlrtRTEI, true);
  i0 = r4->size[0];
  r4->size[0] = nm1d2;
  emxEnsureCapacity_int32_T(sp, r4, i0, &t_emlrtRTEI);
  nm1d2 = 0;
  for (idx = 0; idx <= nx; idx++) {
    if (isconnected->data[idx]) {
      r4->data[nm1d2] = idx + 1;
      nm1d2++;
    }
  }

  loop_ub = r4->size[0] - 1;
  nx = EE_mat->size[0];
  nm1d2 = EE_mat->size[1];
  nx *= nm1d2;
  for (i0 = 0; i0 <= loop_ub; i0++) {
    idx = r4->data[i0];
    if (!((idx >= 1) && (idx <= nx))) {
      emlrtDynamicBoundsCheckR2012b(idx, 1, nx, &eb_emlrtBCI, sp);
    }

    EE_mat->data[idx - 1] = 0.0;
  }

  /* Remove selfconnections */
  /* I->I Synapses */
  ndbl = PopParams->Kii / (PopParams->IPopNum - 1.0);
  i0 = ii->size[0];
  ii->size[0] = Icells->size[1];
  emxEnsureCapacity_int32_T(sp, ii, i0, &u_emlrtRTEI);
  loop_ub = Icells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    apnd = Icells->data[Icells->size[0] * i0];
    if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
      emlrtIntegerCheckR2012b(apnd, &u_emlrtDCI, sp);
    }

    idx = (int32_T)PopNum;
    nm1d2 = (int32_T)apnd;
    if (!((nm1d2 >= 1) && (nm1d2 <= idx))) {
      emlrtDynamicBoundsCheckR2012b(nm1d2, 1, idx, &fb_emlrtBCI, sp);
    }

    ii->data[i0] = nm1d2 - 1;
  }

  i0 = r3->size[0];
  r3->size[0] = Icells->size[1];
  emxEnsureCapacity_int32_T(sp, r3, i0, &v_emlrtRTEI);
  loop_ub = Icells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    idx = (int32_T)PopNum;
    nm1d2 = (int32_T)Icells->data[Icells->size[0] * i0];
    if (!((nm1d2 >= 1) && (nm1d2 <= idx))) {
      emlrtDynamicBoundsCheckR2012b(nm1d2, 1, idx, &gb_emlrtBCI, sp);
    }

    r3->data[i0] = nm1d2 - 1;
  }

  st.site = &f_emlrtRSI;
  b_rand(&st, PopParams->IPopNum, b_EI_mat);
  loop_ub = b_EI_mat->size[0] * b_EI_mat->size[1] - 1;
  i0 = b_EI_mat->size[0] * b_EI_mat->size[1];
  emxEnsureCapacity_real_T(sp, b_EI_mat, i0, &w_emlrtRTEI);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    b_EI_mat->data[i0] = (b_EI_mat->data[i0] <= ndbl);
  }

  b_ii[0] = ii->size[0];
  b_ii[1] = r3->size[0];
  emlrtSubAssignSizeCheckR2012b(&b_ii[0], 2, &(*(int32_T (*)[2])b_EI_mat->size)
    [0], 2, &fc_emlrtECI, sp);
  loop_ub = b_EI_mat->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    nm1d2 = b_EI_mat->size[0];
    for (idx = 0; idx < nm1d2; idx++) {
      II_mat->data[ii->data[idx] + II_mat->size[0] * r3->data[i0]] =
        b_EI_mat->data[idx + b_EI_mat->size[0] * i0];
    }
  }

  loop_ub = II_mat->size[0] * II_mat->size[1] - 1;
  i0 = II_mat->size[0] * II_mat->size[1];
  emxEnsureCapacity_real_T(sp, II_mat, i0, &x_emlrtRTEI);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    II_mat->data[i0] *= PopParams->Wii;
  }

  for (i0 = 0; i0 < 2; i0++) {
    V0range[i0] = II_mat->size[i0];
  }

  i0 = isconnected->size[0] * isconnected->size[1];
  isconnected->size[0] = (int32_T)V0range[0];
  emxEnsureCapacity_boolean_T(sp, isconnected, i0, &y_emlrtRTEI);
  i0 = isconnected->size[0] * isconnected->size[1];
  isconnected->size[1] = (int32_T)V0range[1];
  emxEnsureCapacity_boolean_T(sp, isconnected, i0, &y_emlrtRTEI);
  loop_ub = (int32_T)V0range[0] * (int32_T)V0range[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    isconnected->data[i0] = true;
  }

  st.site = &g_emlrtRSI;
  diag(&st, isconnected, x);
  st.site = &g_emlrtRSI;
  b_diag(&st, x, isconnected);
  nx = isconnected->size[0] * isconnected->size[1] - 1;
  nm1d2 = 0;
  for (idx = 0; idx <= nx; idx++) {
    if (isconnected->data[idx]) {
      nm1d2++;
    }
  }

  emxInit_int32_T(sp, &r5, 1, &t_emlrtRTEI, true);
  i0 = r5->size[0];
  r5->size[0] = nm1d2;
  emxEnsureCapacity_int32_T(sp, r5, i0, &t_emlrtRTEI);
  nm1d2 = 0;
  for (idx = 0; idx <= nx; idx++) {
    if (isconnected->data[idx]) {
      r5->data[nm1d2] = idx + 1;
      nm1d2++;
    }
  }

  loop_ub = r5->size[0] - 1;
  nx = II_mat->size[0];
  nm1d2 = II_mat->size[1];
  nx *= nm1d2;
  for (i0 = 0; i0 <= loop_ub; i0++) {
    idx = r5->data[i0];
    if (!((idx >= 1) && (idx <= nx))) {
      emlrtDynamicBoundsCheckR2012b(idx, 1, nx, &hb_emlrtBCI, sp);
    }

    II_mat->data[idx - 1] = 0.0;
  }

  emxFree_int32_T(sp, &r5);

  /* Remove selfconnections */
  /* E->I Synapses */
  ndbl = PopParams->Kie / PopParams->EPopNum;
  i0 = ii->size[0];
  ii->size[0] = Icells->size[1];
  emxEnsureCapacity_int32_T(sp, ii, i0, &ab_emlrtRTEI);
  loop_ub = Icells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    idx = (int32_T)PopNum;
    nm1d2 = (int32_T)Icells->data[Icells->size[0] * i0];
    if (!((nm1d2 >= 1) && (nm1d2 <= idx))) {
      emlrtDynamicBoundsCheckR2012b(nm1d2, 1, idx, &ib_emlrtBCI, sp);
    }

    ii->data[i0] = nm1d2 - 1;
  }

  i0 = r3->size[0];
  r3->size[0] = Ecells->size[1];
  emxEnsureCapacity_int32_T(sp, r3, i0, &bb_emlrtRTEI);
  loop_ub = Ecells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    idx = (int32_T)PopNum;
    nm1d2 = (int32_T)Ecells->data[Ecells->size[0] * i0];
    if (!((nm1d2 >= 1) && (nm1d2 <= idx))) {
      emlrtDynamicBoundsCheckR2012b(nm1d2, 1, idx, &jb_emlrtBCI, sp);
    }

    r3->data[i0] = nm1d2 - 1;
  }

  st.site = &h_emlrtRSI;
  c_rand(&st, PopParams->IPopNum, PopParams->EPopNum, b_EI_mat);
  loop_ub = b_EI_mat->size[0] * b_EI_mat->size[1] - 1;
  i0 = b_EI_mat->size[0] * b_EI_mat->size[1];
  emxEnsureCapacity_real_T(sp, b_EI_mat, i0, &cb_emlrtRTEI);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    b_EI_mat->data[i0] = (b_EI_mat->data[i0] <= ndbl);
  }

  b_ii[0] = ii->size[0];
  b_ii[1] = r3->size[0];
  emlrtSubAssignSizeCheckR2012b(&b_ii[0], 2, &(*(int32_T (*)[2])b_EI_mat->size)
    [0], 2, &ec_emlrtECI, sp);
  loop_ub = b_EI_mat->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    nm1d2 = b_EI_mat->size[0];
    for (idx = 0; idx < nm1d2; idx++) {
      IE_mat->data[ii->data[idx] + IE_mat->size[0] * r3->data[i0]] =
        b_EI_mat->data[idx + b_EI_mat->size[0] * i0];
    }
  }

  loop_ub = IE_mat->size[0] * IE_mat->size[1] - 1;
  i0 = IE_mat->size[0] * IE_mat->size[1];
  emxEnsureCapacity_real_T(sp, IE_mat, i0, &db_emlrtRTEI);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    IE_mat->data[i0] *= PopParams->Wie;
  }

  /* I->E Synapses */
  ndbl = PopParams->Kei / PopParams->IPopNum;
  i0 = ii->size[0];
  ii->size[0] = Ecells->size[1];
  emxEnsureCapacity_int32_T(sp, ii, i0, &eb_emlrtRTEI);
  loop_ub = Ecells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    idx = (int32_T)PopNum;
    nm1d2 = (int32_T)Ecells->data[Ecells->size[0] * i0];
    if (!((nm1d2 >= 1) && (nm1d2 <= idx))) {
      emlrtDynamicBoundsCheckR2012b(nm1d2, 1, idx, &kb_emlrtBCI, sp);
    }

    ii->data[i0] = nm1d2 - 1;
  }

  i0 = r3->size[0];
  r3->size[0] = Icells->size[1];
  emxEnsureCapacity_int32_T(sp, r3, i0, &fb_emlrtRTEI);
  loop_ub = Icells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    idx = (int32_T)PopNum;
    nm1d2 = (int32_T)Icells->data[Icells->size[0] * i0];
    if (!((nm1d2 >= 1) && (nm1d2 <= idx))) {
      emlrtDynamicBoundsCheckR2012b(nm1d2, 1, idx, &lb_emlrtBCI, sp);
    }

    r3->data[i0] = nm1d2 - 1;
  }

  st.site = &i_emlrtRSI;
  c_rand(&st, PopParams->EPopNum, PopParams->IPopNum, b_EI_mat);
  loop_ub = b_EI_mat->size[0] * b_EI_mat->size[1] - 1;
  i0 = b_EI_mat->size[0] * b_EI_mat->size[1];
  emxEnsureCapacity_real_T(sp, b_EI_mat, i0, &gb_emlrtRTEI);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    b_EI_mat->data[i0] = (b_EI_mat->data[i0] <= ndbl);
  }

  b_ii[0] = ii->size[0];
  b_ii[1] = r3->size[0];
  emlrtSubAssignSizeCheckR2012b(&b_ii[0], 2, &(*(int32_T (*)[2])b_EI_mat->size)
    [0], 2, &dc_emlrtECI, sp);
  loop_ub = b_EI_mat->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    nm1d2 = b_EI_mat->size[0];
    for (idx = 0; idx < nm1d2; idx++) {
      EI_mat->data[ii->data[idx] + EI_mat->size[0] * r3->data[i0]] =
        b_EI_mat->data[idx + b_EI_mat->size[0] * i0];
    }
  }

  loop_ub = EI_mat->size[0] * EI_mat->size[1] - 1;
  i0 = EI_mat->size[0] * EI_mat->size[1];
  emxEnsureCapacity_real_T(sp, EI_mat, i0, &hb_emlrtRTEI);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    EI_mat->data[i0] *= PopParams->Wei;
  }

  for (i0 = 0; i0 < 2; i0++) {
    b_EE_mat[i0] = EE_mat->size[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    b_ii[i0] = II_mat->size[i0];
  }

  if ((b_EE_mat[0] != b_ii[0]) || (b_EE_mat[1] != b_ii[1])) {
    emlrtSizeEqCheckNDR2012b(&b_EE_mat[0], &b_ii[0], &cc_emlrtECI, sp);
  }

  for (i0 = 0; i0 < 2; i0++) {
    b_EE_mat[i0] = EE_mat->size[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    c_EI_mat[i0] = EI_mat->size[i0];
  }

  if ((b_EE_mat[0] != c_EI_mat[0]) || (b_EE_mat[1] != c_EI_mat[1])) {
    emlrtSizeEqCheckNDR2012b(&b_EE_mat[0], &c_EI_mat[0], &cc_emlrtECI, sp);
  }

  for (i0 = 0; i0 < 2; i0++) {
    b_EE_mat[i0] = EE_mat->size[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    b_ii[i0] = IE_mat->size[i0];
  }

  if ((b_EE_mat[0] != b_ii[0]) || (b_EE_mat[1] != b_ii[1])) {
    emlrtSizeEqCheckNDR2012b(&b_EE_mat[0], &b_ii[0], &cc_emlrtECI, sp);
  }

  i0 = isconnected->size[0] * isconnected->size[1];
  isconnected->size[0] = EE_mat->size[0];
  isconnected->size[1] = EE_mat->size[1];
  emxEnsureCapacity_boolean_T(sp, isconnected, i0, &ib_emlrtRTEI);
  loop_ub = EE_mat->size[0] * EE_mat->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    isconnected->data[i0] = (((EE_mat->data[i0] + II_mat->data[i0]) +
      EI_mat->data[i0]) + IE_mat->data[i0] > 0.0);
  }

  emxInit_real_T1(sp, &E_L, 1, &jb_emlrtRTEI, true);

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
  apnd = PopParams->EPopNum;
  if (!(apnd >= 0.0)) {
    emlrtNonNegativeCheckR2012b(apnd, &w_emlrtDCI, sp);
  }

  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &v_emlrtDCI, sp);
  }

  ndbl = PopParams->IPopNum;
  if (!(ndbl >= 0.0)) {
    emlrtNonNegativeCheckR2012b(ndbl, &w_emlrtDCI, sp);
  }

  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &v_emlrtDCI, sp);
  }

  E_L->size[0] = (int32_T)apnd + (int32_T)ndbl;
  emxEnsureCapacity_real_T1(sp, E_L, i0, &jb_emlrtRTEI);
  apnd = PopParams->EPopNum;
  if (!(apnd >= 0.0)) {
    emlrtNonNegativeCheckR2012b(apnd, &y_emlrtDCI, sp);
  }

  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &x_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    E_L->data[i0] = PopParams->E_L[0];
  }

  apnd = PopParams->IPopNum;
  if (!(apnd >= 0.0)) {
    emlrtNonNegativeCheckR2012b(apnd, &y_emlrtDCI, sp);
  }

  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &x_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    apnd = PopParams->EPopNum;
    if (!(apnd >= 0.0)) {
      emlrtNonNegativeCheckR2012b(apnd, &w_emlrtDCI, sp);
    }

    if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
      emlrtIntegerCheckR2012b(apnd, &v_emlrtDCI, sp);
    }

    E_L->data[i0 + (int32_T)apnd] = PopParams->E_L[1];
  }

  emxInit_real_T1(sp, &g_L, 1, &kb_emlrtRTEI, true);
  i0 = g_L->size[0];
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &ab_emlrtDCI, sp);
  }

  ndbl = PopParams->IPopNum;
  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &ab_emlrtDCI, sp);
  }

  g_L->size[0] = (int32_T)apnd + (int32_T)ndbl;
  emxEnsureCapacity_real_T1(sp, g_L, i0, &kb_emlrtRTEI);
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &bb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    g_L->data[i0] = PopParams->g_L[0];
  }

  apnd = PopParams->IPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &bb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    apnd = PopParams->EPopNum;
    if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
      emlrtIntegerCheckR2012b(apnd, &ab_emlrtDCI, sp);
    }

    g_L->data[i0 + (int32_T)apnd] = PopParams->g_L[1];
  }

  emxInit_real_T1(sp, &C, 1, &lb_emlrtRTEI, true);
  i0 = C->size[0];
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &cb_emlrtDCI, sp);
  }

  ndbl = PopParams->IPopNum;
  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &cb_emlrtDCI, sp);
  }

  C->size[0] = (int32_T)apnd + (int32_T)ndbl;
  emxEnsureCapacity_real_T1(sp, C, i0, &lb_emlrtRTEI);
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &db_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    C->data[i0] = PopParams->C[0];
  }

  apnd = PopParams->IPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &db_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    apnd = PopParams->EPopNum;
    if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
      emlrtIntegerCheckR2012b(apnd, &cb_emlrtDCI, sp);
    }

    C->data[i0 + (int32_T)apnd] = PopParams->C[1];
  }

  emxInit_real_T1(sp, &I_e, 1, &og_emlrtRTEI, true);
  i0 = I_e->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &eb_emlrtDCI, sp);
  }

  I_e->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, I_e, i0, &mb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &eb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    I_e->data[i0] = PopParams->I_e;
  }

  emxInit_real_T1(sp, &V_th, 1, &nb_emlrtRTEI, true);
  i0 = V_th->size[0];
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &fb_emlrtDCI, sp);
  }

  ndbl = PopParams->IPopNum;
  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &fb_emlrtDCI, sp);
  }

  V_th->size[0] = (int32_T)apnd + (int32_T)ndbl;
  emxEnsureCapacity_real_T1(sp, V_th, i0, &nb_emlrtRTEI);
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &gb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    V_th->data[i0] = PopParams->V_th[0];
  }

  apnd = PopParams->IPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &gb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    apnd = PopParams->EPopNum;
    if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
      emlrtIntegerCheckR2012b(apnd, &fb_emlrtDCI, sp);
    }

    V_th->data[i0 + (int32_T)apnd] = PopParams->V_th[1];
  }

  emxInit_real_T1(sp, &V_reset, 1, &ob_emlrtRTEI, true);
  i0 = V_reset->size[0];
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &hb_emlrtDCI, sp);
  }

  ndbl = PopParams->IPopNum;
  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &hb_emlrtDCI, sp);
  }

  V_reset->size[0] = (int32_T)apnd + (int32_T)ndbl;
  emxEnsureCapacity_real_T1(sp, V_reset, i0, &ob_emlrtRTEI);
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &ib_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    V_reset->data[i0] = PopParams->V_reset[0];
  }

  apnd = PopParams->IPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &ib_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    apnd = PopParams->EPopNum;
    if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
      emlrtIntegerCheckR2012b(apnd, &hb_emlrtDCI, sp);
    }

    V_reset->data[i0 + (int32_T)apnd] = PopParams->V_reset[1];
  }

  emxInit_real_T1(sp, &t_ref, 1, &pg_emlrtRTEI, true);
  i0 = t_ref->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &jb_emlrtDCI, sp);
  }

  t_ref->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, t_ref, i0, &pb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &jb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    t_ref->data[i0] = PopParams->t_ref;
  }

  emxInit_real_T1(sp, &sigma, 1, &qg_emlrtRTEI, true);
  i0 = sigma->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &kb_emlrtDCI, sp);
  }

  sigma->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, sigma, i0, &qb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &kb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    sigma->data[i0] = PopParams->sigma;
  }

  emxInit_real_T1(sp, &theta, 1, &rg_emlrtRTEI, true);
  i0 = theta->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &lb_emlrtDCI, sp);
  }

  theta->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, theta, i0, &rb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &lb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    theta->data[i0] = PopParams->theta;
  }

  emxInit_real_T1(sp, &E_w, 1, &sg_emlrtRTEI, true);
  i0 = E_w->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &mb_emlrtDCI, sp);
  }

  E_w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, E_w, i0, &sb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &mb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    E_w->data[i0] = PopParams->E_w;
  }

  emxInit_real_T1(sp, &b_w, 1, &tg_emlrtRTEI, true);
  i0 = b_w->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &nb_emlrtDCI, sp);
  }

  b_w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, b_w, i0, &tb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &nb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_w->data[i0] = PopParams->b_w;
  }

  emxInit_real_T1(sp, &delta_T, 1, &ug_emlrtRTEI, true);
  i0 = delta_T->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &ob_emlrtDCI, sp);
  }

  delta_T->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, delta_T, i0, &ub_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &ob_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    delta_T->data[i0] = PopParams->delta_T;
  }

  emxInit_real_T1(sp, &gwnorm, 1, &vg_emlrtRTEI, true);
  i0 = gwnorm->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &pb_emlrtDCI, sp);
  }

  gwnorm->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, gwnorm, i0, &vb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &pb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    gwnorm->data[i0] = PopParams->gwnorm;
  }

  emxInit_real_T1(sp, &w_r, 1, &wg_emlrtRTEI, true);
  i0 = w_r->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &qb_emlrtDCI, sp);
  }

  w_r->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, w_r, i0, &wb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &qb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    w_r->data[i0] = PopParams->w_r;
  }

  emxInit_real_T1(sp, &b, 1, &xg_emlrtRTEI, true);
  i0 = b->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &rb_emlrtDCI, sp);
  }

  b->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, b, i0, &xb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &rb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    b->data[i0] = PopParams->b;
  }

  emxInit_real_T1(sp, &E_e, 1, &yg_emlrtRTEI, true);
  i0 = E_e->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &sb_emlrtDCI, sp);
  }

  E_e->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, E_e, i0, &yb_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &sb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    E_e->data[i0] = PopParams->E_e;
  }

  emxInit_real_T1(sp, &E_i, 1, &ah_emlrtRTEI, true);
  i0 = E_i->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &tb_emlrtDCI, sp);
  }

  E_i->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, E_i, i0, &ac_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &tb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    E_i->data[i0] = PopParams->E_i;
  }

  emxInit_real_T1(sp, &tau_s, 1, &bc_emlrtRTEI, true);
  i0 = tau_s->size[0];
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &ub_emlrtDCI, sp);
  }

  ndbl = PopParams->IPopNum;
  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &ub_emlrtDCI, sp);
  }

  tau_s->size[0] = (int32_T)apnd + (int32_T)ndbl;
  emxEnsureCapacity_real_T1(sp, tau_s, i0, &bc_emlrtRTEI);
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &vb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    tau_s->data[i0] = PopParams->tau_s[0];
  }

  apnd = PopParams->IPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &vb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    apnd = PopParams->EPopNum;
    if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
      emlrtIntegerCheckR2012b(apnd, &ub_emlrtDCI, sp);
    }

    tau_s->data[i0 + (int32_T)apnd] = PopParams->tau_s[1];
  }

  emxInit_real_T1(sp, &ELearningRate, 1, &cc_emlrtRTEI, true);
  i0 = ELearningRate->size[0];
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &wb_emlrtDCI, sp);
  }

  ELearningRate->size[0] = (int32_T)apnd;
  emxEnsureCapacity_real_T1(sp, ELearningRate, i0, &cc_emlrtRTEI);
  apnd = PopParams->EPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &wb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    ELearningRate->data[i0] = PopParams->LearningRate;
  }

  i0 = ILearningRate->size[0] * ILearningRate->size[1];
  ILearningRate->size[0] = 1;
  apnd = PopParams->IPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &g_emlrtDCI, sp);
  }

  ILearningRate->size[1] = (int32_T)apnd;
  emxEnsureCapacity_real_T(sp, ILearningRate, i0, &dc_emlrtRTEI);
  apnd = PopParams->IPopNum;
  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &xb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd;
  for (i0 = 0; i0 < loop_ub; i0++) {
    ILearningRate->data[i0] = PopParams->LearningRate;
  }

  emxInit_real_T1(sp, &tauSTDP, 1, &ec_emlrtRTEI, true);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &emlrtDCI, sp);
  }

  /* Target Rate for Excitatory cells (units of Hz) */
  i0 = tauSTDP->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &yb_emlrtDCI, sp);
  }

  tauSTDP->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, tauSTDP, i0, &ec_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &yb_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    tauSTDP->data[i0] = PopParams->tauSTDP;
  }

  emxInit_real_T1(sp, &alpha, 1, &fc_emlrtRTEI, true);

  /* Time Constant for the STDP curve (Units of ms) */
  apnd = 2.0 * (PopParams->TargetRate / 1000.0) * PopParams->tauSTDP;
  i0 = alpha->size[0];
  ndbl = PopParams->EPopNum;
  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &ac_emlrtDCI, sp);
  }

  alpha->size[0] = (int32_T)ndbl;
  emxEnsureCapacity_real_T1(sp, alpha, i0, &fc_emlrtRTEI);
  ndbl = PopParams->EPopNum;
  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &ac_emlrtDCI, sp);
  }

  loop_ub = (int32_T)ndbl;
  for (i0 = 0; i0 < loop_ub; i0++) {
    alpha->data[i0] = apnd;
  }

  emxInit_real_T1(sp, &V, 1, &gc_emlrtRTEI, true);

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
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &bc_emlrtDCI, sp);
  }

  V->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, V, i0, &gc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &bc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    V->data[i0] = 0.0;
  }

  emxInit_real_T1(sp, &g_e, 1, &hc_emlrtRTEI, true);

  /* Membrane Potential */
  i0 = g_e->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &cc_emlrtDCI, sp);
  }

  g_e->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, g_e, i0, &hc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &cc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    g_e->data[i0] = 0.0;
  }

  emxInit_real_T1(sp, &g_i, 1, &ic_emlrtRTEI, true);

  /* conductance of synapse  */
  i0 = g_i->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &dc_emlrtDCI, sp);
  }

  g_i->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, g_i, i0, &ic_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &dc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    g_i->data[i0] = 0.0;
  }

  emxInit_real_T1(sp, &g_w, 1, &jc_emlrtRTEI, true);

  /* conductance of synapse  */
  i0 = g_w->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &ec_emlrtDCI, sp);
  }

  g_w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, g_w, i0, &jc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &ec_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    g_w->data[i0] = 0.0;
  }

  emxInit_real_T1(sp, &a_w, 1, &kc_emlrtRTEI, true);

  /* conductance of adaptation  */
  i0 = a_w->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &fc_emlrtDCI, sp);
  }

  a_w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, a_w, i0, &kc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &fc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    a_w->data[i0] = 0.0;
  }

  emxInit_real_T1(sp, &s, 1, &lc_emlrtRTEI, true);

  /* adaptation rise (1/ms) */
  i0 = s->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &gc_emlrtDCI, sp);
  }

  s->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, s, i0, &lc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &gc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    s->data[i0] = 0.0;
  }

  emxInit_real_T1(sp, &w, 1, &mc_emlrtRTEI, true);

  /* synapse  */
  i0 = w->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &hc_emlrtDCI, sp);
  }

  w->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, w, i0, &mc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &hc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    w->data[i0] = 0.0;
  }

  emxInit_real_T1(sp, &X_t, 1, &nc_emlrtRTEI, true);

  /* adaptation */
  i0 = X_t->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &ic_emlrtDCI, sp);
  }

  X_t->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, X_t, i0, &nc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &ic_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    X_t->data[i0] = 0.0;
  }

  emxInit_real_T1(sp, &t_r, 1, &oc_emlrtRTEI, true);

  /* OU noise */
  i0 = t_r->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &jc_emlrtDCI, sp);
  }

  t_r->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, t_r, i0, &oc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &jc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    t_r->data[i0] = 0.0;
  }

  emxInit_real_T1(sp, &b_x, 1, &pc_emlrtRTEI, true);
  i0 = b_x->size[0];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &kc_emlrtDCI, sp);
  }

  b_x->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_real_T1(sp, b_x, i0, &pc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &kc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_x->data[i0] = 0.0;
  }

  /* Synaptic trace */
  /* Saved Variables */
  i0 = SimValues->t->size[0] * SimValues->t->size[1];
  SimValues->t->size[0] = 1;
  SimValues->t->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->t, i0, &qc_emlrtRTEI);
  loop_ub = r1->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->t->data[i0] = rtNaN;
  }

  i0 = SimValues->V->size[0] * SimValues->V->size[1];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &h_emlrtDCI, sp);
  }

  SimValues->V->size[0] = (int32_T)PopNum;
  SimValues->V->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->V, i0, &rc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &lc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum * r1->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->V->data[i0] = rtNaN;
  }

  i0 = SimValues->g_w->size[0] * SimValues->g_w->size[1];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &i_emlrtDCI, sp);
  }

  SimValues->g_w->size[0] = (int32_T)PopNum;
  SimValues->g_w->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->g_w, i0, &sc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &mc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum * r1->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->g_w->data[i0] = rtNaN;
  }

  i0 = SimValues->g_e->size[0] * SimValues->g_e->size[1];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &j_emlrtDCI, sp);
  }

  SimValues->g_e->size[0] = (int32_T)PopNum;
  SimValues->g_e->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->g_e, i0, &tc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &nc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum * r1->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->g_e->data[i0] = rtNaN;
  }

  i0 = SimValues->g_i->size[0] * SimValues->g_i->size[1];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &k_emlrtDCI, sp);
  }

  SimValues->g_i->size[0] = (int32_T)PopNum;
  SimValues->g_i->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->g_i, i0, &uc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &oc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum * r1->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->g_i->data[i0] = rtNaN;
  }

  i0 = SimValues->s->size[0] * SimValues->s->size[1];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &l_emlrtDCI, sp);
  }

  SimValues->s->size[0] = (int32_T)PopNum;
  SimValues->s->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->s, i0, &vc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &pc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum * r1->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->s->data[i0] = rtNaN;
  }

  i0 = SimValues->w->size[0] * SimValues->w->size[1];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &m_emlrtDCI, sp);
  }

  SimValues->w->size[0] = (int32_T)PopNum;
  SimValues->w->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->w, i0, &wc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &qc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum * r1->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->w->data[i0] = rtNaN;
  }

  i0 = SimValues->a_w->size[0] * SimValues->a_w->size[1];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &n_emlrtDCI, sp);
  }

  SimValues->a_w->size[0] = (int32_T)PopNum;
  SimValues->a_w->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->a_w, i0, &xc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &rc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum * r1->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->a_w->data[i0] = rtNaN;
  }

  i0 = SimValues->Input->size[0] * SimValues->Input->size[1];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &o_emlrtDCI, sp);
  }

  SimValues->Input->size[0] = (int32_T)PopNum;
  SimValues->Input->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->Input, i0, &yc_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &sc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum * r1->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->Input->data[i0] = rtNaN;
  }

  i0 = SimValues->t_weight->size[0] * SimValues->t_weight->size[1];
  SimValues->t_weight->size[0] = 1;
  SimValues->t_weight->size[1] = r2->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->t_weight, i0, &ad_emlrtRTEI);
  loop_ub = r2->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->t_weight->data[i0] = rtNaN;
  }

  i0 = SimValues->WeightMat->size[0] * SimValues->WeightMat->size[1] *
    SimValues->WeightMat->size[2];
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &p_emlrtDCI, sp);
  }

  SimValues->WeightMat->size[0] = (int32_T)PopNum;
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &q_emlrtDCI, sp);
  }

  SimValues->WeightMat->size[1] = (int32_T)PopNum;
  SimValues->WeightMat->size[2] = r2->size[1];
  emxEnsureCapacity_real_T2(sp, SimValues->WeightMat, i0, &bd_emlrtRTEI);
  if (PopNum != (int32_T)muDoubleScalarFloor(PopNum)) {
    emlrtIntegerCheckR2012b(PopNum, &tc_emlrtDCI, sp);
    emlrtIntegerCheckR2012b(PopNum, &tc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)PopNum * (int32_T)PopNum * r2->size[1];
  emxFree_real_T(sp, &r2);
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->WeightMat->data[i0] = rtNaN;
  }

  emxInit_boolean_T(sp, &c_x, 2, &cd_emlrtRTEI, true);
  st.site = &j_emlrtRSI;
  i0 = c_x->size[0] * c_x->size[1];
  c_x->size[0] = 1;
  c_x->size[1] = recordVALs->size[1];
  emxEnsureCapacity_boolean_T(&st, c_x, i0, &cd_emlrtRTEI);
  loop_ub = recordVALs->size[0] * recordVALs->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    c_x->data[i0] = (recordVALs->data[i0] != 0.0);
  }

  emxInit_int32_T1(&st, &c_ii, 2, &fh_emlrtRTEI, true);
  b_st.site = &nb_emlrtRSI;
  nx = c_x->size[1];
  c_st.site = &ob_emlrtRSI;
  idx = 0;
  i0 = c_ii->size[0] * c_ii->size[1];
  c_ii->size[0] = 1;
  c_ii->size[1] = c_x->size[1];
  emxEnsureCapacity_int32_T1(&c_st, c_ii, i0, &dd_emlrtRTEI);
  d_st.site = &pb_emlrtRSI;
  overflow = ((!(1 > c_x->size[1])) && (c_x->size[1] > 2147483646));
  if (overflow) {
    e_st.site = &kb_emlrtRSI;
    check_forloop_overflow_error(&e_st);
  }

  nm1d2 = 1;
  exitg1 = false;
  while ((!exitg1) && (nm1d2 <= nx)) {
    if (c_x->data[nm1d2 - 1]) {
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

  if (!(idx <= c_x->size[1])) {
    emlrtErrorWithMessageIdR2018a(&c_st, &xh_emlrtRTEI,
      "Coder:builtins:AssertionFailed", "Coder:builtins:AssertionFailed", 0);
  }

  if (c_x->size[1] == 1) {
    if (idx == 0) {
      i0 = c_ii->size[0] * c_ii->size[1];
      c_ii->size[1] = 0;
      emxEnsureCapacity_int32_T1(&c_st, c_ii, i0, &ed_emlrtRTEI);
    }
  } else {
    i0 = c_ii->size[0] * c_ii->size[1];
    if (1 > idx) {
      c_ii->size[1] = 0;
    } else {
      c_ii->size[1] = idx;
    }

    emxEnsureCapacity_int32_T1(&c_st, c_ii, i0, &ed_emlrtRTEI);
  }

  emxFree_boolean_T(&c_st, &c_x);
  emxInit_real32_T(&c_st, &spikes, 2, &bh_emlrtRTEI, true);
  ndbl = muDoubleScalarRound((real_T)c_ii->size[1] * TimeParams->dt);
  i0 = spikes->size[0] * spikes->size[1];
  apnd = PopNum * ndbl * 20.0;
  if (!(apnd >= 0.0)) {
    emlrtNonNegativeCheckR2012b(apnd, &s_emlrtDCI, sp);
  }

  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &r_emlrtDCI, sp);
  }

  spikes->size[0] = (int32_T)apnd;
  spikes->size[1] = 2;
  emxEnsureCapacity_real32_T(sp, spikes, i0, &fd_emlrtRTEI);
  apnd = PopNum * ndbl * 20.0;
  if (!(apnd >= 0.0)) {
    emlrtNonNegativeCheckR2012b(apnd, &vc_emlrtDCI, sp);
  }

  if (apnd != (int32_T)muDoubleScalarFloor(apnd)) {
    emlrtIntegerCheckR2012b(apnd, &uc_emlrtDCI, sp);
  }

  loop_ub = (int32_T)apnd << 1;
  emxFree_int32_T(sp, &c_ii);
  for (i0 = 0; i0 < loop_ub; i0++) {
    spikes->data[i0] = ((real32_T)rtNaN);
  }

  /* assume mean rate 20Hz */
  /*  if no spike adaptation, set to steady state????? or set to alpha(v_th) */
  nx = b->size[0];
  for (idx = 0; idx < nx; idx++) {
    if (b->data[idx] == 0.0) {
      i0 = w_r->size[0];
      if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &o_emlrtBCI, sp);
      }
    }
  }

  nx = b->size[0];
  for (idx = 0; idx < nx; idx++) {
    if (b->data[idx] == 0.0) {
      i0 = b_w->size[0];
      if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &n_emlrtBCI, sp);
      }
    }
  }

  nx = b->size[0];
  for (idx = 0; idx < nx; idx++) {
    if (b->data[idx] == 0.0) {
      i0 = V_reset->size[0];
      if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &m_emlrtBCI, sp);
      }
    }
  }

  nx = b->size[0];
  for (idx = 0; idx < nx; idx++) {
    if (b->data[idx] == 0.0) {
      i0 = E_L->size[0];
      if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &l_emlrtBCI, sp);
      }
    }
  }

  nx = b->size[0];
  for (idx = 0; idx < nx; idx++) {
    if (b->data[idx] == 0.0) {
      i0 = delta_T->size[0];
      if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &k_emlrtBCI, sp);
      }
    }
  }

  nx = b->size[0] - 1;
  nm1d2 = 0;
  for (idx = 0; idx <= nx; idx++) {
    if (b->data[idx] == 0.0) {
      nm1d2++;
    }
  }

  emxInit_int32_T(sp, &r6, 1, &t_emlrtRTEI, true);
  i0 = r6->size[0];
  r6->size[0] = nm1d2;
  emxEnsureCapacity_int32_T(sp, r6, i0, &t_emlrtRTEI);
  nm1d2 = 0;
  for (idx = 0; idx <= nx; idx++) {
    if (b->data[idx] == 0.0) {
      r6->data[nm1d2] = idx + 1;
      nm1d2++;
    }
  }

  emxInit_real_T1(sp, &b_w_r, 1, &gd_emlrtRTEI, true);
  i0 = b_w_r->size[0];
  b_w_r->size[0] = r6->size[0];
  emxEnsureCapacity_real_T1(sp, b_w_r, i0, &gd_emlrtRTEI);
  loop_ub = r6->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_w_r->data[i0] = w_r->data[r6->data[i0] - 1] * b_w->data[r6->data[i0] - 1];
  }

  emxInit_real_T1(sp, &r7, 1, &hd_emlrtRTEI, true);
  nm1d2 = w_r->size[0];
  i0 = r7->size[0];
  r7->size[0] = r6->size[0];
  emxEnsureCapacity_real_T1(sp, r7, i0, &hd_emlrtRTEI);
  loop_ub = r6->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    idx = r6->data[i0];
    if (!((idx >= 1) && (idx <= nm1d2))) {
      emlrtDynamicBoundsCheckR2012b(idx, 1, nm1d2, &mb_emlrtBCI, sp);
    }

    r7->data[i0] = 1.0 - w_r->data[idx - 1];
  }

  emxFree_int32_T(sp, &r6);
  emxInit_real_T1(sp, &r8, 1, &eh_emlrtRTEI, true);
  st.site = &k_emlrtRSI;
  rdivide(&st, b_w_r, r7, r8);
  nx = b->size[0] - 1;
  nm1d2 = 0;
  for (idx = 0; idx <= nx; idx++) {
    if (b->data[idx] == 0.0) {
      nm1d2++;
    }
  }

  emxInit_int32_T(sp, &r9, 1, &t_emlrtRTEI, true);
  i0 = r9->size[0];
  r9->size[0] = nm1d2;
  emxEnsureCapacity_int32_T(sp, r9, i0, &t_emlrtRTEI);
  nm1d2 = 0;
  for (idx = 0; idx <= nx; idx++) {
    if (b->data[idx] == 0.0) {
      r9->data[nm1d2] = idx + 1;
      nm1d2++;
    }
  }

  emxInit_real_T1(sp, &r10, 1, &t_emlrtRTEI, true);
  i0 = r10->size[0];
  r10->size[0] = r9->size[0];
  emxEnsureCapacity_real_T1(sp, r10, i0, &id_emlrtRTEI);
  loop_ub = r9->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r10->data[i0] = (V_reset->data[r9->data[i0] - 1] - E_L->data[r9->data[i0] -
                     1]) * delta_T->data[r9->data[i0] - 1];
  }

  emxFree_int32_T(sp, &r9);
  st.site = &k_emlrtRSI;
  b_exp(&st, r10);
  i0 = r8->size[0];
  idx = r10->size[0];
  if (i0 != idx) {
    emlrtSizeEqCheck1DR2012b(i0, idx, &bc_emlrtECI, sp);
  }

  i0 = r8->size[0];
  emxEnsureCapacity_real_T1(sp, r8, i0, &gd_emlrtRTEI);
  loop_ub = r8->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r8->data[i0] *= r10->data[i0];
  }

  nx = b->size[0];
  nm1d2 = 0;
  for (idx = 0; idx < nx; idx++) {
    if (b->data[idx] == 0.0) {
      nm1d2++;
    }
  }

  i0 = r8->size[0];
  if (nm1d2 != i0) {
    emlrtSubAssignSizeCheck1dR2017a(nm1d2, i0, &ac_emlrtECI, sp);
  }

  nx = b->size[0];
  nm1d2 = 0;
  for (idx = 0; idx < nx; idx++) {
    if (b->data[idx] == 0.0) {
      i0 = b->size[0];
      if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &nb_emlrtBCI, sp);
      }

      b->data[idx] = r8->data[nm1d2];
      nm1d2++;
    }
  }

  emxInit_real_T1(sp, &dX, 1, &jd_emlrtRTEI, true);

  /*  If no noise */
  i0 = dX->size[0];
  dX->size[0] = 1;
  emxEnsureCapacity_real_T1(sp, dX, i0, &jd_emlrtRTEI);
  dX->data[0] = 0.0;

  /* V - Voltage Equation */
  /* s - Synaptic Output  */
  /* w - Adaptation Variable */
  /* x - Synaptic Trace for STDP */
  /*  Initial Conditions - random voltages */
  /* Improvement?: set # initial spiking neurons instead of hard coding  */
  /* range: E_L-Vth */
  /* chance of initial spiking  */
  st.site = &l_emlrtRSI;
  b_st.site = &sb_emlrtRSI;
  c_st.site = &tb_emlrtRSI;
  d_st.site = &ub_emlrtRSI;
  if ((E_L->size[0] == 1) || (E_L->size[0] != 1)) {
  } else {
    emlrtErrorWithMessageIdR2018a(&d_st, &ai_emlrtRTEI,
      "Coder:toolbox:autoDimIncompatibility",
      "Coder:toolbox:autoDimIncompatibility", 0);
  }

  if (!(E_L->size[0] >= 1)) {
    emlrtErrorWithMessageIdR2018a(&d_st, &yh_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero",
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  e_st.site = &vb_emlrtRSI;
  if (E_L->size[0] <= 2) {
    if (E_L->size[0] == 1) {
      cdiff = E_L->data[0];
    } else if ((E_L->data[0] > E_L->data[1]) || (muDoubleScalarIsNaN(E_L->data[0])
                && (!muDoubleScalarIsNaN(E_L->data[1])))) {
      cdiff = E_L->data[1];
    } else {
      cdiff = E_L->data[0];
    }
  } else {
    f_st.site = &xb_emlrtRSI;
    idx = findFirst(&f_st, E_L);
    if (idx == 0) {
      cdiff = E_L->data[0];
    } else {
      f_st.site = &wb_emlrtRSI;
      cdiff = E_L->data[idx - 1];
      g_st.site = &ac_emlrtRSI;
      overflow = ((!(idx + 1 > E_L->size[0])) && (E_L->size[0] > 2147483646));
      if (overflow) {
        h_st.site = &kb_emlrtRSI;
        check_forloop_overflow_error(&h_st);
      }

      while (idx + 1 <= E_L->size[0]) {
        if (cdiff > E_L->data[idx]) {
          cdiff = E_L->data[idx];
        }

        idx++;
      }
    }
  }

  st.site = &l_emlrtRSI;
  b_st.site = &bc_emlrtRSI;
  c_st.site = &tb_emlrtRSI;
  d_st.site = &ub_emlrtRSI;
  if ((V_th->size[0] == 1) || (V_th->size[0] != 1)) {
  } else {
    emlrtErrorWithMessageIdR2018a(&d_st, &ai_emlrtRTEI,
      "Coder:toolbox:autoDimIncompatibility",
      "Coder:toolbox:autoDimIncompatibility", 0);
  }

  if (!(V_th->size[0] >= 1)) {
    emlrtErrorWithMessageIdR2018a(&d_st, &yh_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero",
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  e_st.site = &vb_emlrtRSI;
  if (V_th->size[0] <= 2) {
    if (V_th->size[0] == 1) {
      ndbl = V_th->data[0];
    } else if ((V_th->data[0] < V_th->data[1]) || (muDoubleScalarIsNaN
                (V_th->data[0]) && (!muDoubleScalarIsNaN(V_th->data[1])))) {
      ndbl = V_th->data[1];
    } else {
      ndbl = V_th->data[0];
    }
  } else {
    f_st.site = &xb_emlrtRSI;
    idx = findFirst(&f_st, V_th);
    if (idx == 0) {
      ndbl = V_th->data[0];
    } else {
      f_st.site = &wb_emlrtRSI;
      ndbl = V_th->data[idx - 1];
      g_st.site = &ac_emlrtRSI;
      overflow = ((!(idx + 1 > V_th->size[0])) && (V_th->size[0] > 2147483646));
      if (overflow) {
        h_st.site = &kb_emlrtRSI;
        check_forloop_overflow_error(&h_st);
      }

      while (idx + 1 <= V_th->size[0]) {
        if (ndbl < V_th->data[idx]) {
          ndbl = V_th->data[idx];
        }

        idx++;
      }
    }
  }

  V0range[0] = cdiff;
  V0range[1] = ndbl;

  /* make this neuron vector */
  i0 = ii->size[0];
  ii->size[0] = (int32_T)PopNum;
  emxEnsureCapacity_int32_T(sp, ii, i0, &kd_emlrtRTEI);
  loop_ub = (int32_T)PopNum;
  for (i0 = 0; i0 < loop_ub; i0++) {
    ii->data[i0] = i0;
  }

  st.site = &m_emlrtRSI;
  d_rand(&st, PopNum, r8);
  apnd = diff(V0range);
  i0 = r8->size[0];
  emxEnsureCapacity_real_T1(sp, r8, i0, &ld_emlrtRTEI);
  loop_ub = r8->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r8->data[i0] *= apnd;
  }

  d_ii[0] = ii->size[0];
  emlrtSubAssignSizeCheckR2012b(&d_ii[0], 1, &(*(int32_T (*)[1])r8->size)[0], 1,
    &wb_emlrtECI, sp);
  loop_ub = r8->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    V->data[ii->data[i0]] = cdiff + r8->data[i0];
  }

  /*  Time Loop */
  savecounter = 1U;
  weightcounter = 1U;
  absa = 0.0;
  tt = 0;
  emxInit_real_T1(sp, &PreIspikes, 1, &ch_emlrtRTEI, true);
  emxInit_real_T1(sp, &PostEspikes, 1, &dh_emlrtRTEI, true);
  emxInit_real32_T(sp, &r11, 2, &t_emlrtRTEI, true);
  emxInit_int32_T1(sp, &r12, 2, &t_emlrtRTEI, true);
  emxInit_int32_T1(sp, &r13, 2, &t_emlrtRTEI, true);
  emxInit_int32_T1(sp, &r14, 2, &t_emlrtRTEI, true);
  emxInit_int32_T1(sp, &r15, 2, &t_emlrtRTEI, true);
  emxInit_int32_T1(sp, &r16, 2, &t_emlrtRTEI, true);
  emxInit_int32_T1(sp, &r17, 2, &t_emlrtRTEI, true);
  emxInit_int32_T1(sp, &r18, 2, &t_emlrtRTEI, true);
  emxInit_int32_T1(sp, &r19, 2, &t_emlrtRTEI, true);
  emxInit_int32_T(sp, &r20, 1, &t_emlrtRTEI, true);
  emxInit_int32_T(sp, &r21, 1, &t_emlrtRTEI, true);
  emxInit_int32_T1(sp, &r22, 2, &md_emlrtRTEI, true);
  emxInit_boolean_T1(sp, &b_sigma, 1, &nd_emlrtRTEI, true);
  while (tt <= r0->size[1] - 1) {
    /*     %% Time Counter */
    if (b_mod(1.0 + (real_T)tt, muDoubleScalarRound((real_T)varargin_2 / 10.0)) ==
        0.0) {
      /* clearly, this needs improvement */
      y = NULL;
      m0 = emlrtCreateDoubleScalar(muDoubleScalarRound(100.0 * (1.0 + (real_T)tt)
        / (real_T)varargin_2));
      emlrtAssign(&y, m0);
      emlrtDisplayR2012b(y, "ans", &emlrtRTEI, sp);
    }

    /*     %% Dynamics: update noise, V,s,w based on values in previous timestep */
    /* Noise input (independent for each neuron... could also be correlated) */
    /* To do: precompte drive, so don't need random number generation each dt */
    i0 = b_sigma->size[0];
    b_sigma->size[0] = sigma->size[0];
    emxEnsureCapacity_boolean_T1(sp, b_sigma, i0, &nd_emlrtRTEI);
    loop_ub = sigma->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_sigma->data[i0] = (sigma->data[i0] != 0.0);
    }

    st.site = &n_emlrtRSI;
    if (ifWhileCond(&st, b_sigma)) {
      i0 = dX->size[0];
      dX->size[0] = theta->size[0];
      emxEnsureCapacity_real_T1(sp, dX, i0, &od_emlrtRTEI);
      loop_ub = theta->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        dX->data[i0] = -theta->data[i0];
      }

      i0 = dX->size[0];
      idx = X_t->size[0];
      if (i0 != idx) {
        emlrtSizeEqCheck1DR2012b(i0, idx, &xb_emlrtECI, sp);
      }

      i0 = r8->size[0];
      r8->size[0] = theta->size[0];
      emxEnsureCapacity_real_T1(sp, r8, i0, &qd_emlrtRTEI);
      loop_ub = theta->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r8->data[i0] = 2.0 * theta->data[i0];
      }

      st.site = &o_emlrtRSI;
      b_sqrt(&st, r8);
      i0 = r8->size[0];
      idx = sigma->size[0];
      if (i0 != idx) {
        emlrtSizeEqCheck1DR2012b(i0, idx, &yb_emlrtECI, sp);
      }

      i0 = r8->size[0];
      emxEnsureCapacity_real_T1(sp, r8, i0, &qd_emlrtRTEI);
      loop_ub = r8->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r8->data[i0] *= sigma->data[i0];
      }

      st.site = &o_emlrtRSI;
      randn(&st, PopNum, r10);
      i0 = r8->size[0];
      idx = r10->size[0];
      if (i0 != idx) {
        emlrtSizeEqCheck1DR2012b(i0, idx, &yb_emlrtECI, sp);
      }

      i0 = dX->size[0];
      emxEnsureCapacity_real_T1(sp, dX, i0, &od_emlrtRTEI);
      loop_ub = dX->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        dX->data[i0] = dX->data[i0] * X_t->data[i0] * dt;
      }

      apnd = dt;
      st.site = &o_emlrtRSI;
      c_sqrt(&st, &apnd);
      i0 = r8->size[0];
      emxEnsureCapacity_real_T1(sp, r8, i0, &qd_emlrtRTEI);
      loop_ub = r8->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r8->data[i0] = r8->data[i0] * r10->data[i0] * apnd;
      }

      i0 = dX->size[0];
      idx = r8->size[0];
      if (i0 != idx) {
        emlrtSizeEqCheck1DR2012b(i0, idx, &xb_emlrtECI, sp);
      }

      i0 = dX->size[0];
      emxEnsureCapacity_real_T1(sp, dX, i0, &vd_emlrtRTEI);
      loop_ub = dX->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        dX->data[i0] += r8->data[i0];
      }
    }

    /* V - Voltage Equation */
    /*                       %Leak */
    /*                       %Adaptation */
    /*        %Synapses */
    i0 = V->size[0];
    idx = E_L->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &vb_emlrtECI, sp);
    }

    i0 = r8->size[0];
    r8->size[0] = g_L->size[0];
    emxEnsureCapacity_real_T1(sp, r8, i0, &rd_emlrtRTEI);
    loop_ub = g_L->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      r8->data[i0] = -g_L->data[i0];
    }

    i0 = r8->size[0];
    idx = V->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &ob_emlrtECI, sp);
    }

    i0 = V->size[0];
    idx = E_w->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &ub_emlrtECI, sp);
    }

    i0 = g_w->size[0];
    idx = V->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &tb_emlrtECI, sp);
    }

    i0 = r8->size[0];
    emxEnsureCapacity_real_T1(sp, r8, i0, &rd_emlrtRTEI);
    loop_ub = r8->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      r8->data[i0] *= V->data[i0] - E_L->data[i0];
    }

    i0 = g_w->size[0];
    emxEnsureCapacity_real_T1(sp, g_w, i0, &sd_emlrtRTEI);
    loop_ub = g_w->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      g_w->data[i0] *= V->data[i0] - E_w->data[i0];
    }

    i0 = r8->size[0];
    idx = g_w->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &ob_emlrtECI, sp);
    }

    i0 = V->size[0];
    idx = E_e->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &sb_emlrtECI, sp);
    }

    i0 = g_e->size[0];
    idx = V->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &rb_emlrtECI, sp);
    }

    i0 = g_e->size[0];
    emxEnsureCapacity_real_T1(sp, g_e, i0, &ud_emlrtRTEI);
    loop_ub = g_e->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      g_e->data[i0] *= V->data[i0] - E_e->data[i0];
    }

    i0 = r8->size[0];
    idx = g_e->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &ob_emlrtECI, sp);
    }

    i0 = V->size[0];
    idx = E_i->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &qb_emlrtECI, sp);
    }

    i0 = g_i->size[0];
    idx = V->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &pb_emlrtECI, sp);
    }

    i0 = g_i->size[0];
    emxEnsureCapacity_real_T1(sp, g_i, i0, &xd_emlrtRTEI);
    loop_ub = g_i->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      g_i->data[i0] *= V->data[i0] - E_i->data[i0];
    }

    i0 = r8->size[0];
    idx = g_i->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &ob_emlrtECI, sp);
    }

    i0 = r8->size[0];
    idx = I_e->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &ob_emlrtECI, sp);
    }

    i0 = r8->size[0];
    idx = X_t->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &ob_emlrtECI, sp);
    }

    i0 = r7->size[0];
    r7->size[0] = r8->size[0];
    emxEnsureCapacity_real_T1(sp, r7, i0, &rd_emlrtRTEI);
    loop_ub = r8->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      r7->data[i0] = ((((r8->data[i0] - g_w->data[i0]) - g_e->data[i0]) -
                       g_i->data[i0]) + I_e->data[i0]) + X_t->data[i0];
    }

    st.site = &p_emlrtRSI;
    rdivide(&st, r7, C, g_e);

    /* External input */
    /* s - Synaptic Output  */
    i0 = b_w_r->size[0];
    b_w_r->size[0] = s->size[0];
    emxEnsureCapacity_real_T1(sp, b_w_r, i0, &yd_emlrtRTEI);
    loop_ub = s->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_w_r->data[i0] = -s->data[i0];
    }

    st.site = &q_emlrtRSI;
    rdivide(&st, b_w_r, tau_s, g_i);

    /* w - Adaptation Variable */
    i0 = a_w->size[0];
    idx = w->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &mb_emlrtECI, sp);
    }

    i0 = b_w->size[0];
    idx = w->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &nb_emlrtECI, sp);
    }

    i0 = a_w->size[0];
    emxEnsureCapacity_real_T1(sp, a_w, i0, &ae_emlrtRTEI);
    loop_ub = a_w->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      a_w->data[i0] *= 1.0 - w->data[i0];
    }

    i0 = r8->size[0];
    r8->size[0] = b_w->size[0];
    emxEnsureCapacity_real_T1(sp, r8, i0, &be_emlrtRTEI);
    loop_ub = b_w->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      r8->data[i0] = b_w->data[i0] * w->data[i0];
    }

    i0 = a_w->size[0];
    idx = r8->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &mb_emlrtECI, sp);
    }

    /* x - Synaptic Trace for STDP */
    i0 = b_w_r->size[0];
    b_w_r->size[0] = b_x->size[0];
    emxEnsureCapacity_real_T1(sp, b_w_r, i0, &ce_emlrtRTEI);
    loop_ub = b_x->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_w_r->data[i0] = -b_x->data[i0];
    }

    st.site = &r_emlrtRSI;
    rdivide(&st, b_w_r, tauSTDP, g_w);
    i0 = X_t->size[0];
    idx = dX->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &lb_emlrtECI, sp);
    }

    i0 = X_t->size[0];
    emxEnsureCapacity_real_T1(sp, X_t, i0, &de_emlrtRTEI);
    loop_ub = X_t->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      X_t->data[i0] += dX->data[i0];
    }

    i0 = g_e->size[0];
    emxEnsureCapacity_real_T1(sp, g_e, i0, &fe_emlrtRTEI);
    loop_ub = g_e->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      g_e->data[i0] *= dt;
    }

    i0 = V->size[0];
    idx = g_e->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &kb_emlrtECI, sp);
    }

    i0 = V->size[0];
    emxEnsureCapacity_real_T1(sp, V, i0, &ge_emlrtRTEI);
    loop_ub = V->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      V->data[i0] += g_e->data[i0];
    }

    i0 = g_i->size[0];
    emxEnsureCapacity_real_T1(sp, g_i, i0, &he_emlrtRTEI);
    loop_ub = g_i->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      g_i->data[i0] *= dt;
    }

    i0 = s->size[0];
    idx = g_i->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &jb_emlrtECI, sp);
    }

    i0 = s->size[0];
    emxEnsureCapacity_real_T1(sp, s, i0, &je_emlrtRTEI);
    loop_ub = s->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      s->data[i0] += g_i->data[i0];
    }

    i0 = a_w->size[0];
    emxEnsureCapacity_real_T1(sp, a_w, i0, &le_emlrtRTEI);
    loop_ub = a_w->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      a_w->data[i0] = (a_w->data[i0] - r8->data[i0]) * dt;
    }

    i0 = w->size[0];
    idx = a_w->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &ib_emlrtECI, sp);
    }

    i0 = w->size[0];
    emxEnsureCapacity_real_T1(sp, w, i0, &me_emlrtRTEI);
    loop_ub = w->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      w->data[i0] += a_w->data[i0];
    }

    i0 = g_w->size[0];
    emxEnsureCapacity_real_T1(sp, g_w, i0, &oe_emlrtRTEI);
    loop_ub = g_w->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      g_w->data[i0] *= dt;
    }

    i0 = b_x->size[0];
    idx = g_w->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &hb_emlrtECI, sp);
    }

    i0 = b_x->size[0];
    emxEnsureCapacity_real_T1(sp, b_x, i0, &pe_emlrtRTEI);
    loop_ub = b_x->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_x->data[i0] += g_w->data[i0];
    }

    /* timecounter = round(timecounter+dt,4);  %Round to deal with computational error */
    /* a_w - Adaptation activation rate for the next time step (unless spike) */
    i0 = w_r->size[0];
    idx = b_w->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &eb_emlrtECI, sp);
    }

    i0 = V->size[0];
    idx = E_L->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &gb_emlrtECI, sp);
    }

    i0 = V->size[0];
    idx = delta_T->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &fb_emlrtECI, sp);
    }

    i0 = b_w_r->size[0];
    b_w_r->size[0] = w_r->size[0];
    emxEnsureCapacity_real_T1(sp, b_w_r, i0, &qe_emlrtRTEI);
    loop_ub = w_r->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_w_r->data[i0] = w_r->data[i0] * b_w->data[i0];
    }

    i0 = r7->size[0];
    r7->size[0] = w_r->size[0];
    emxEnsureCapacity_real_T1(sp, r7, i0, &re_emlrtRTEI);
    loop_ub = w_r->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      r7->data[i0] = 1.0 - w_r->data[i0];
    }

    st.site = &s_emlrtRSI;
    rdivide(&st, b_w_r, r7, a_w);
    i0 = r8->size[0];
    r8->size[0] = V->size[0];
    emxEnsureCapacity_real_T1(sp, r8, i0, &se_emlrtRTEI);
    loop_ub = V->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      r8->data[i0] = (V->data[i0] - E_L->data[i0]) * delta_T->data[i0];
    }

    st.site = &s_emlrtRSI;
    b_exp(&st, r8);
    i0 = a_w->size[0];
    idx = r8->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &eb_emlrtECI, sp);
    }

    i0 = a_w->size[0];
    emxEnsureCapacity_real_T1(sp, a_w, i0, &te_emlrtRTEI);
    loop_ub = a_w->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      a_w->data[i0] *= r8->data[i0];
    }

    /*     %% Spiking */
    i0 = V->size[0];
    idx = V_th->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &db_emlrtECI, sp);
    }

    i0 = b_sigma->size[0];
    b_sigma->size[0] = V->size[0];
    emxEnsureCapacity_boolean_T1(sp, b_sigma, i0, &ue_emlrtRTEI);
    loop_ub = V->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_sigma->data[i0] = (V->data[i0] > V_th->data[i0]);
    }

    st.site = &t_emlrtRSI;
    if (any(&st, b_sigma)) {
      /* Find neurons that crossed threshold and record the spiketimes  */
      i0 = V->size[0];
      idx = V_th->size[0];
      if (i0 != idx) {
        emlrtSizeEqCheck1DR2012b(i0, idx, &cb_emlrtECI, sp);
      }

      st.site = &u_emlrtRSI;
      i0 = x->size[0];
      x->size[0] = V->size[0];
      emxEnsureCapacity_boolean_T1(&st, x, i0, &we_emlrtRTEI);
      loop_ub = V->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        x->data[i0] = (V->data[i0] > V_th->data[i0]);
      }

      b_st.site = &nb_emlrtRSI;
      nx = x->size[0];
      c_st.site = &ob_emlrtRSI;
      idx = 0;
      i0 = ii->size[0];
      ii->size[0] = x->size[0];
      emxEnsureCapacity_int32_T(&c_st, ii, i0, &dd_emlrtRTEI);
      d_st.site = &pb_emlrtRSI;
      overflow = (x->size[0] > 2147483646);
      if (overflow) {
        e_st.site = &kb_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      nm1d2 = 1;
      exitg1 = false;
      while ((!exitg1) && (nm1d2 <= nx)) {
        if (x->data[nm1d2 - 1]) {
          idx++;
          ii->data[idx - 1] = nm1d2;
          if (idx >= nx) {
            exitg1 = true;
          } else {
            nm1d2++;
          }
        } else {
          nm1d2++;
        }
      }

      if (!(idx <= x->size[0])) {
        emlrtErrorWithMessageIdR2018a(&c_st, &xh_emlrtRTEI,
          "Coder:builtins:AssertionFailed", "Coder:builtins:AssertionFailed", 0);
      }

      if (x->size[0] == 1) {
        if (idx == 0) {
          i0 = ii->size[0];
          ii->size[0] = 0;
          emxEnsureCapacity_int32_T(&c_st, ii, i0, &ed_emlrtRTEI);
        }
      } else {
        if (1 > idx) {
          i0 = 0;
        } else {
          i0 = idx;
        }

        d_st.site = &ic_emlrtRSI;
        overflow = !(ii->size[0] != 1);
        if (overflow) {
          overflow = false;
          if (i0 != 1) {
            overflow = true;
          }

          if (overflow) {
            overflow = true;
          } else {
            overflow = false;
          }
        } else {
          overflow = false;
        }

        e_st.site = &jc_emlrtRSI;
        if (overflow) {
          emlrtErrorWithMessageIdR2018a(&e_st, &wh_emlrtRTEI,
            "Coder:FE:PotentialVectorVector", "Coder:FE:PotentialVectorVector",
            0);
        }

        idx = ii->size[0];
        ii->size[0] = i0;
        emxEnsureCapacity_int32_T(&c_st, ii, idx, &ed_emlrtRTEI);
      }

      i0 = g_i->size[0];
      g_i->size[0] = ii->size[0];
      emxEnsureCapacity_real_T1(&st, g_i, i0, &af_emlrtRTEI);
      loop_ub = ii->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        g_i->data[i0] = ii->data[i0];
      }

      i0 = recordVALs->size[1];
      idx = tt + 1;
      if (!((idx >= 1) && (idx <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &bb_emlrtBCI, sp);
      }

      st.site = &v_emlrtRSI;
      toLogicalCheck(&st, recordVALs->data[tt]);
      if (recordVALs->data[tt] != 0.0) {
        i0 = g_i->size[0];
        nm1d2 = spikes->size[0];
        idx = ii->size[0];
        ii->size[0] = (int32_T)((real_T)i0 - 1.0) + 1;
        emxEnsureCapacity_int32_T(sp, ii, idx, &df_emlrtRTEI);
        loop_ub = (int32_T)((real_T)i0 - 1.0);
        for (i0 = 0; i0 <= loop_ub; i0++) {
          idx = (int32_T)(absa + (1.0 + (real_T)i0));
          if (!((idx >= 1) && (idx <= nm1d2))) {
            emlrtDynamicBoundsCheckR2012b(idx, 1, nm1d2, &ob_emlrtBCI, sp);
          }

          ii->data[i0] = idx - 1;
        }

        st.site = &w_emlrtRSI;
        i0 = g_e->size[0];
        g_e->size[0] = g_i->size[0];
        emxEnsureCapacity_real_T1(&st, g_e, i0, &gf_emlrtRTEI);
        loop_ub = g_i->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          g_e->data[i0] = -0.0 - dt;
        }

        b_st.site = &lc_emlrtRSI;
        c_st.site = &mc_emlrtRSI;
        overflow = true;
        if (g_i->size[0] != g_e->size[0]) {
          overflow = false;
        }

        if (!overflow) {
          emlrtErrorWithMessageIdR2018a(&c_st, &vh_emlrtRTEI,
            "MATLAB:catenate:matrixDimensionMismatch",
            "MATLAB:catenate:matrixDimensionMismatch", 0);
        }

        i0 = r11->size[0] * r11->size[1];
        r11->size[0] = g_e->size[0];
        r11->size[1] = 2;
        emxEnsureCapacity_real32_T(sp, r11, i0, &lf_emlrtRTEI);
        loop_ub = g_e->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          r11->data[i0] = (real32_T)g_e->data[i0];
        }

        loop_ub = g_i->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          r11->data[i0 + r11->size[0]] = (real32_T)g_i->data[i0];
        }

        b_ii[0] = ii->size[0];
        b_ii[1] = 2;
        emlrtSubAssignSizeCheckR2012b(&b_ii[0], 2, &(*(int32_T (*)[2])r11->size)
          [0], 2, &j_emlrtECI, sp);
        for (i0 = 0; i0 < 2; i0++) {
          loop_ub = r11->size[0];
          for (idx = 0; idx < loop_ub; idx++) {
            spikes->data[ii->data[idx] + spikes->size[0] * i0] = r11->data[idx +
              r11->size[0] * i0];
          }
        }
      }

      absa += (real_T)g_i->size[0];

      /* Jump the conductance */
      nm1d2 = s->size[0];
      i0 = ii->size[0];
      ii->size[0] = g_i->size[0];
      emxEnsureCapacity_int32_T(sp, ii, i0, &ff_emlrtRTEI);
      loop_ub = g_i->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)g_i->data[i0];
        if (!((idx >= 1) && (idx <= nm1d2))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nm1d2, &pb_emlrtBCI, sp);
        }

        ii->data[i0] = idx;
      }

      nm1d2 = s->size[0];
      loop_ub = g_i->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)g_i->data[i0];
        if (!((idx >= 1) && (idx <= nm1d2))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nm1d2, &qb_emlrtBCI, sp);
        }
      }

      i0 = ii->size[0];
      idx = g_i->size[0];
      if (i0 != idx) {
        emlrtSubAssignSizeCheck1dR2017a(i0, idx, &bb_emlrtECI, sp);
      }

      i0 = b_w_r->size[0];
      b_w_r->size[0] = g_i->size[0];
      emxEnsureCapacity_real_T1(sp, b_w_r, i0, &jf_emlrtRTEI);
      loop_ub = g_i->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        b_w_r->data[i0] = s->data[(int32_T)g_i->data[i0] - 1] + 1.0;
      }

      loop_ub = b_w_r->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        s->data[ii->data[i0] - 1] = b_w_r->data[i0];
      }

      /* Set spiking neurons refractory period  */
      nm1d2 = t_r->size[0];
      i0 = ii->size[0];
      ii->size[0] = g_i->size[0];
      emxEnsureCapacity_int32_T(sp, ii, i0, &kf_emlrtRTEI);
      loop_ub = g_i->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)g_i->data[i0];
        if (!((idx >= 1) && (idx <= nm1d2))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nm1d2, &rb_emlrtBCI, sp);
        }

        ii->data[i0] = idx;
      }

      nm1d2 = t_ref->size[0];
      loop_ub = g_i->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)g_i->data[i0];
        if (!((idx >= 1) && (idx <= nm1d2))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nm1d2, &sb_emlrtBCI, sp);
        }
      }

      i0 = ii->size[0];
      idx = g_i->size[0];
      if (i0 != idx) {
        emlrtSubAssignSizeCheck1dR2017a(i0, idx, &p_emlrtECI, sp);
      }

      loop_ub = g_i->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        t_r->data[ii->data[i0] - 1] = t_ref->data[(int32_T)g_i->data[i0] - 1];
      }

      /* Jump the synaptic trace */
      nm1d2 = b_x->size[0];
      i0 = ii->size[0];
      ii->size[0] = g_i->size[0];
      emxEnsureCapacity_int32_T(sp, ii, i0, &of_emlrtRTEI);
      loop_ub = g_i->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)g_i->data[i0];
        if (!((idx >= 1) && (idx <= nm1d2))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nm1d2, &tb_emlrtBCI, sp);
        }

        ii->data[i0] = idx;
      }

      nm1d2 = b_x->size[0];
      loop_ub = g_i->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)g_i->data[i0];
        if (!((idx >= 1) && (idx <= nm1d2))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nm1d2, &ub_emlrtBCI, sp);
        }
      }

      i0 = ii->size[0];
      idx = g_i->size[0];
      if (i0 != idx) {
        emlrtSubAssignSizeCheck1dR2017a(i0, idx, &ab_emlrtECI, sp);
      }

      i0 = b_w_r->size[0];
      b_w_r->size[0] = g_i->size[0];
      emxEnsureCapacity_real_T1(sp, b_w_r, i0, &pf_emlrtRTEI);
      loop_ub = g_i->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        b_w_r->data[i0] = b_x->data[(int32_T)g_i->data[i0] - 1] + 1.0;
      }

      loop_ub = b_w_r->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        b_x->data[ii->data[i0] - 1] = b_w_r->data[i0];
      }

      /* Implement STDP (Vogels 2011 SuppEqn 4/5) I->E only */
      /* Presynaptic I Cells */
      /* PreIspikes = intersect(spikeneurons,Icells); */
      nx = g_i->size[0] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (g_i->data[idx] > EPopNum) {
          nm1d2++;
        }
      }

      i0 = PreIspikes->size[0];
      PreIspikes->size[0] = nm1d2;
      emxEnsureCapacity_real_T1(sp, PreIspikes, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (g_i->data[idx] > EPopNum) {
          i0 = g_i->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &vb_emlrtBCI, sp);
          }

          PreIspikes->data[nm1d2] = g_i->data[idx];
          nm1d2++;
        }
      }

      nx = EcellIDX->size[1];
      for (idx = 0; idx < nx; idx++) {
        if (EcellIDX->data[idx]) {
          i0 = b_x->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &f_emlrtBCI, sp);
          }
        }
      }

      nx = EcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          nm1d2++;
        }
      }

      i0 = r22->size[0] * r22->size[1];
      r22->size[0] = 1;
      r22->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(sp, r22, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          r22->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      i0 = r4->size[0];
      r4->size[0] = r22->size[1];
      emxEnsureCapacity_int32_T(sp, r4, i0, &vf_emlrtRTEI);
      loop_ub = r22->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r4->data[i0] = r22->data[r22->size[0] * i0];
      }

      i0 = r4->size[0];
      idx = alpha->size[0];
      if (i0 != idx) {
        emlrtSizeEqCheck1DR2012b(i0, idx, &y_emlrtECI, sp);
      }

      nx = EcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          nm1d2++;
        }
      }

      i0 = r12->size[0] * r12->size[1];
      r12->size[0] = 1;
      r12->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(sp, r12, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          r12->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      i0 = r4->size[0];
      r4->size[0] = r12->size[1];
      emxEnsureCapacity_int32_T(sp, r4, i0, &vf_emlrtRTEI);
      loop_ub = r12->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r4->data[i0] = r12->data[r12->size[0] * i0];
      }

      i0 = ELearningRate->size[0];
      idx = r4->size[0];
      if (i0 != idx) {
        emlrtSizeEqCheck1DR2012b(i0, idx, &x_emlrtECI, sp);
      }

      nx = EcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          nm1d2++;
        }
      }

      i0 = r13->size[0] * r13->size[1];
      r13->size[0] = 1;
      r13->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(sp, r13, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          r13->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      i0 = r8->size[0];
      r8->size[0] = ELearningRate->size[0];
      emxEnsureCapacity_real_T1(sp, r8, i0, &yf_emlrtRTEI);
      loop_ub = ELearningRate->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r8->data[i0] = ELearningRate->data[i0] * (b_x->data[r13->data[r13->size
          [0] * i0] - 1] - alpha->data[i0]);
      }

      iv6[0] = 1;
      d_ii[0] = r8->size[0];
      emlrtSizeEqCheckNDR2012b(iv6, d_ii, &w_emlrtECI, sp);
      for (idx = 0; idx < 2; idx++) {
        c_EI_mat[idx] = 1;
      }

      b_ii[0] = 1;
      b_ii[1] = PreIspikes->size[0];
      if (1 != b_ii[1]) {
        emlrtSizeEqCheckNDR2012b(&c_EI_mat[0], &b_ii[0], &v_emlrtECI, sp);
      }

      nx = EcellIDX->size[1];
      for (idx = 0; idx < nx; idx++) {
        if (EcellIDX->data[idx]) {
          i0 = EI_mat->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &e_emlrtBCI, sp);
          }
        }
      }

      nx = EI_mat->size[1];
      i0 = ii->size[0];
      ii->size[0] = PreIspikes->size[0];
      emxEnsureCapacity_int32_T(sp, ii, i0, &cg_emlrtRTEI);
      loop_ub = PreIspikes->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)PreIspikes->data[i0];
        if (!((idx >= 1) && (idx <= nx))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nx, &wb_emlrtBCI, sp);
        }

        ii->data[i0] = idx - 1;
      }

      nx = EcellIDX->size[1];
      for (idx = 0; idx < nx; idx++) {
        if (EcellIDX->data[idx]) {
          i0 = EI_mat->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &d_emlrtBCI, sp);
          }
        }
      }

      nx = EI_mat->size[1];
      loop_ub = PreIspikes->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)PreIspikes->data[i0];
        if (!((idx >= 1) && (idx <= nx))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nx, &xb_emlrtBCI, sp);
        }
      }

      nx = EcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          nm1d2++;
        }
      }

      i0 = r14->size[0] * r14->size[1];
      r14->size[0] = 1;
      r14->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(sp, r14, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          r14->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      i0 = r4->size[0];
      r4->size[0] = r14->size[1];
      emxEnsureCapacity_int32_T(sp, r4, i0, &eg_emlrtRTEI);
      loop_ub = r14->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r4->data[i0] = r14->data[r14->size[0] * i0];
      }

      c_EI_mat[0] = r4->size[0];
      c_EI_mat[1] = ii->size[0];
      i0 = r4->size[0];
      r4->size[0] = r14->size[1];
      emxEnsureCapacity_int32_T(sp, r4, i0, &fg_emlrtRTEI);
      loop_ub = r14->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r4->data[i0] = r14->data[r14->size[0] * i0];
      }

      b_ii[0] = r4->size[0];
      b_ii[1] = PreIspikes->size[0];
      emlrtSubAssignSizeCheckR2012b(&c_EI_mat[0], 2, &b_ii[0], 2, &u_emlrtECI,
        sp);
      nx = EcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          nm1d2++;
        }
      }

      i0 = r15->size[0] * r15->size[1];
      r15->size[0] = 1;
      r15->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(sp, r15, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EcellIDX->data[idx]) {
          r15->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      apnd = r8->data[0];
      i0 = b_EI_mat->size[0] * b_EI_mat->size[1];
      b_EI_mat->size[0] = r15->size[1];
      b_EI_mat->size[1] = PreIspikes->size[0];
      emxEnsureCapacity_real_T(sp, b_EI_mat, i0, &gg_emlrtRTEI);
      loop_ub = PreIspikes->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        nm1d2 = r15->size[1];
        for (idx = 0; idx < nm1d2; idx++) {
          b_EI_mat->data[idx + b_EI_mat->size[0] * i0] = EI_mat->data[(r15->
            data[r15->size[0] * idx] + EI_mat->size[0] * ((int32_T)
            PreIspikes->data[i0] - 1)) - 1] + apnd;
        }
      }

      loop_ub = b_EI_mat->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        nm1d2 = b_EI_mat->size[0];
        for (idx = 0; idx < nm1d2; idx++) {
          EI_mat->data[(r15->data[r15->size[0] * idx] + EI_mat->size[0] *
                        ii->data[i0]) - 1] = b_EI_mat->data[idx + b_EI_mat->
            size[0] * i0];
        }
      }

      /* Postsynaptic E cells */
      /* PostEspikes = intersect(spikeneurons,Ecells); */
      nx = g_i->size[0] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (g_i->data[idx] <= EPopNum) {
          nm1d2++;
        }
      }

      i0 = PostEspikes->size[0];
      PostEspikes->size[0] = nm1d2;
      emxEnsureCapacity_real_T1(sp, PostEspikes, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (g_i->data[idx] <= EPopNum) {
          i0 = g_i->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &yb_emlrtBCI, sp);
          }

          PostEspikes->data[nm1d2] = g_i->data[idx];
          nm1d2++;
        }
      }

      nx = IcellIDX->size[1];
      for (idx = 0; idx < nx; idx++) {
        if (IcellIDX->data[idx]) {
          i0 = b_x->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &c_emlrtBCI, sp);
          }
        }
      }

      nx = IcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (IcellIDX->data[idx]) {
          nm1d2++;
        }
      }

      i0 = r16->size[0] * r16->size[1];
      r16->size[0] = 1;
      r16->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(sp, r16, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (IcellIDX->data[idx]) {
          r16->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      for (i0 = 0; i0 < 2; i0++) {
        b_ii[i0] = ILearningRate->size[i0];
      }

      for (i0 = 0; i0 < 2; i0++) {
        c_EI_mat[i0] = r16->size[i0];
      }

      if ((b_ii[0] != c_EI_mat[0]) || (b_ii[1] != c_EI_mat[1])) {
        emlrtSizeEqCheckNDR2012b(&b_ii[0], &c_EI_mat[0], &t_emlrtECI, sp);
      }

      nx = IcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (IcellIDX->data[idx]) {
          nm1d2++;
        }
      }

      i0 = r17->size[0] * r17->size[1];
      r17->size[0] = 1;
      r17->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(sp, r17, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (IcellIDX->data[idx]) {
          r17->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      i0 = r1->size[0] * r1->size[1];
      r1->size[0] = 1;
      r1->size[1] = ILearningRate->size[1];
      emxEnsureCapacity_real_T(sp, r1, i0, &hg_emlrtRTEI);
      loop_ub = ILearningRate->size[0] * ILearningRate->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r1->data[i0] = ILearningRate->data[i0] * b_x->data[r17->data[i0] - 1];
      }

      for (idx = 0; idx < 2; idx++) {
        c_EI_mat[idx] = 1;
      }

      for (i0 = 0; i0 < 2; i0++) {
        b_ii[i0] = r1->size[i0];
      }

      if ((1 != b_ii[0]) || (1 != b_ii[1])) {
        emlrtSizeEqCheckNDR2012b(&c_EI_mat[0], &b_ii[0], &t_emlrtECI, sp);
      }

      iv6[0] = 1;
      d_ii[0] = PostEspikes->size[0];
      emlrtSizeEqCheckNDR2012b(iv6, d_ii, &s_emlrtECI, sp);
      nx = EI_mat->size[0];
      i0 = ii->size[0];
      ii->size[0] = PostEspikes->size[0];
      emxEnsureCapacity_int32_T(sp, ii, i0, &ig_emlrtRTEI);
      loop_ub = PostEspikes->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)PostEspikes->data[i0];
        if (!((idx >= 1) && (idx <= nx))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nx, &ac_emlrtBCI, sp);
        }

        ii->data[i0] = idx - 1;
      }

      nx = IcellIDX->size[1];
      for (idx = 0; idx < nx; idx++) {
        if (IcellIDX->data[idx]) {
          i0 = EI_mat->size[1];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &b_emlrtBCI, sp);
          }
        }
      }

      nx = EI_mat->size[0];
      loop_ub = PostEspikes->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = (int32_T)PostEspikes->data[i0];
        if (!((idx >= 1) && (idx <= nx))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nx, &bc_emlrtBCI, sp);
        }
      }

      nx = IcellIDX->size[1];
      for (idx = 0; idx < nx; idx++) {
        if (IcellIDX->data[idx]) {
          i0 = EI_mat->size[1];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &emlrtBCI, sp);
          }
        }
      }

      nx = IcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (IcellIDX->data[idx]) {
          nm1d2++;
        }
      }

      i0 = r18->size[0] * r18->size[1];
      r18->size[0] = 1;
      r18->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(sp, r18, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (IcellIDX->data[idx]) {
          r18->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      i0 = r4->size[0];
      r4->size[0] = r18->size[1];
      emxEnsureCapacity_int32_T(sp, r4, i0, &jg_emlrtRTEI);
      loop_ub = r18->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r4->data[i0] = r18->data[r18->size[0] * i0];
      }

      b_ii[0] = ii->size[0];
      b_ii[1] = r4->size[0];
      i0 = r4->size[0];
      r4->size[0] = r18->size[1];
      emxEnsureCapacity_int32_T(sp, r4, i0, &kg_emlrtRTEI);
      loop_ub = r18->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r4->data[i0] = r18->data[r18->size[0] * i0];
      }

      c_EI_mat[0] = PostEspikes->size[0];
      c_EI_mat[1] = r4->size[0];
      emlrtSubAssignSizeCheckR2012b(&b_ii[0], 2, &c_EI_mat[0], 2, &r_emlrtECI,
        sp);
      nx = IcellIDX->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (IcellIDX->data[idx]) {
          nm1d2++;
        }
      }

      i0 = r19->size[0] * r19->size[1];
      r19->size[0] = 1;
      r19->size[1] = nm1d2;
      emxEnsureCapacity_int32_T1(sp, r19, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (IcellIDX->data[idx]) {
          r19->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      apnd = r1->data[0];
      i0 = b_EI_mat->size[0] * b_EI_mat->size[1];
      b_EI_mat->size[0] = PostEspikes->size[0];
      b_EI_mat->size[1] = r19->size[1];
      emxEnsureCapacity_real_T(sp, b_EI_mat, i0, &lg_emlrtRTEI);
      loop_ub = r19->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        nm1d2 = PostEspikes->size[0];
        for (idx = 0; idx < nm1d2; idx++) {
          b_EI_mat->data[idx + b_EI_mat->size[0] * i0] = EI_mat->data[((int32_T)
            PostEspikes->data[idx] + EI_mat->size[0] * (r19->data[r19->size[0] *
            i0] - 1)) - 1] + apnd;
        }
      }

      loop_ub = b_EI_mat->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        nm1d2 = b_EI_mat->size[0];
        for (idx = 0; idx < nm1d2; idx++) {
          EI_mat->data[ii->data[idx] + EI_mat->size[0] * (r19->data[r19->size[0]
            * i0] - 1)] = b_EI_mat->data[idx + b_EI_mat->size[0] * i0];
        }
      }

      for (i0 = 0; i0 < 2; i0++) {
        c_EI_mat[i0] = EI_mat->size[i0];
      }

      for (i0 = 0; i0 < 2; i0++) {
        b_ii[i0] = isconnected->size[i0];
      }

      if ((c_EI_mat[0] != b_ii[0]) || (c_EI_mat[1] != b_ii[1])) {
        emlrtSizeEqCheckNDR2012b(&c_EI_mat[0], &b_ii[0], &q_emlrtECI, sp);
      }

      loop_ub = EI_mat->size[0] * EI_mat->size[1] - 1;
      i0 = EI_mat->size[0] * EI_mat->size[1];
      emxEnsureCapacity_real_T(sp, EI_mat, i0, &mg_emlrtRTEI);
      for (i0 = 0; i0 <= loop_ub; i0++) {
        EI_mat->data[i0] *= (real_T)isconnected->data[i0];
      }

      /* Keep only connected pairs */
      nx = EI_mat->size[0] * EI_mat->size[1] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EI_mat->data[idx] <= 0.0) {
          nm1d2++;
        }
      }

      i0 = r20->size[0];
      r20->size[0] = nm1d2;
      emxEnsureCapacity_int32_T(sp, r20, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (EI_mat->data[idx] <= 0.0) {
          r20->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      loop_ub = r20->size[0] - 1;
      nx = EI_mat->size[0];
      nm1d2 = EI_mat->size[1];
      nx *= nm1d2;
      for (i0 = 0; i0 <= loop_ub; i0++) {
        idx = r20->data[i0];
        if (!((idx >= 1) && (idx <= nx))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nx, &cc_emlrtBCI, sp);
        }

        EI_mat->data[idx - 1] = 0.0;
      }

      /* Get rid of any negative synapses... */
    }

    /*     %%  Refractory period Countdowns */
    i0 = b_sigma->size[0];
    b_sigma->size[0] = t_r->size[0];
    emxEnsureCapacity_boolean_T1(sp, b_sigma, i0, &ve_emlrtRTEI);
    loop_ub = t_r->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_sigma->data[i0] = (t_r->data[i0] > 0.0);
    }

    st.site = &x_emlrtRSI;
    if (any(&st, b_sigma)) {
      /* Hold voltage, synaptic/adaptation rates at spike levels */
      nx = t_r->size[0];
      for (idx = 0; idx < nx; idx++) {
        if (t_r->data[idx] > 0.0) {
          i0 = V_reset->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &i_emlrtBCI, sp);
          }
        }
      }

      nx = t_r->size[0];
      for (idx = 0; idx < nx; idx++) {
        if (t_r->data[idx] > 0.0) {
          i0 = V->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &dc_emlrtBCI, sp);
          }

          V->data[idx] = V_reset->data[idx];
        }
      }

      nx = t_r->size[0];
      for (idx = 0; idx < nx; idx++) {
        if (t_r->data[idx] > 0.0) {
          i0 = b->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &h_emlrtBCI, sp);
          }
        }
      }

      nx = t_r->size[0];
      for (idx = 0; idx < nx; idx++) {
        if (t_r->data[idx] > 0.0) {
          i0 = a_w->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &ec_emlrtBCI, sp);
          }

          a_w->data[idx] = b->data[idx];
        }
      }

      /* Count down the refractory period */
      nx = t_r->size[0];
      for (idx = 0; idx < nx; idx++) {
        if (t_r->data[idx] > 0.0) {
          i0 = t_r->size[0];
          if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
            emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &g_emlrtBCI, sp);
          }
        }
      }

      nx = t_r->size[0] - 1;
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (t_r->data[idx] > 0.0) {
          nm1d2++;
        }
      }

      i0 = r21->size[0];
      r21->size[0] = nm1d2;
      emxEnsureCapacity_int32_T(sp, r21, i0, &t_emlrtRTEI);
      nm1d2 = 0;
      for (idx = 0; idx <= nx; idx++) {
        if (t_r->data[idx] > 0.0) {
          r21->data[nm1d2] = idx + 1;
          nm1d2++;
        }
      }

      nm1d2 = t_r->size[0];
      i0 = b_w_r->size[0];
      b_w_r->size[0] = r21->size[0];
      emxEnsureCapacity_real_T1(sp, b_w_r, i0, &hf_emlrtRTEI);
      loop_ub = r21->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        b_w_r->data[i0] = t_r->data[r21->data[i0] - 1] - dt;
      }

      loop_ub = b_w_r->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        idx = r21->data[i0];
        if (!((idx >= 1) && (idx <= nm1d2))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, nm1d2, &fc_emlrtBCI, sp);
        }

        t_r->data[idx - 1] = b_w_r->data[i0];
      }
    }

    /*     %% Synaptic,Adaptaion Conductances for the next time step */
    i0 = gwnorm->size[0];
    idx = w->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &o_emlrtECI, sp);
    }

    i0 = g_w->size[0];
    g_w->size[0] = gwnorm->size[0];
    emxEnsureCapacity_real_T1(sp, g_w, i0, &xe_emlrtRTEI);
    loop_ub = gwnorm->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      g_w->data[i0] = gwnorm->data[i0] * w->data[i0];
    }

    st.site = &y_emlrtRSI;
    b_st.site = &oc_emlrtRSI;
    if (!(EE_mat->size[1] == s->size[0])) {
      if (((EE_mat->size[0] == 1) && (EE_mat->size[1] == 1)) || (s->size[0] == 1))
      {
        emlrtErrorWithMessageIdR2018a(&b_st, &th_emlrtRTEI,
          "Coder:toolbox:mtimes_noDynamicScalarExpansion",
          "Coder:toolbox:mtimes_noDynamicScalarExpansion", 0);
      } else {
        emlrtErrorWithMessageIdR2018a(&b_st, &uh_emlrtRTEI,
          "Coder:MATLAB:innerdim", "Coder:MATLAB:innerdim", 0);
      }
    }

    if ((EE_mat->size[1] == 1) || (s->size[0] == 1)) {
      i0 = g_e->size[0];
      g_e->size[0] = EE_mat->size[0];
      emxEnsureCapacity_real_T1(&st, g_e, i0, &ye_emlrtRTEI);
      loop_ub = EE_mat->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        g_e->data[i0] = 0.0;
        nm1d2 = EE_mat->size[1];
        for (idx = 0; idx < nm1d2; idx++) {
          g_e->data[i0] += EE_mat->data[i0 + EE_mat->size[0] * idx] * s->
            data[idx];
        }
      }
    } else {
      b_st.site = &nc_emlrtRSI;
      if ((EE_mat->size[0] == 0) || (EE_mat->size[1] == 0) || (s->size[0] == 0))
      {
        i0 = g_e->size[0];
        g_e->size[0] = EE_mat->size[0];
        emxEnsureCapacity_real_T1(&b_st, g_e, i0, &ye_emlrtRTEI);
        loop_ub = EE_mat->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          g_e->data[i0] = 0.0;
        }
      } else {
        c_st.site = &pc_emlrtRSI;
        c_st.site = &qc_emlrtRSI;
        TRANSA = 'N';
        TRANSB = 'N';
        ndbl = 1.0;
        cdiff = 0.0;
        m_t = (ptrdiff_t)EE_mat->size[0];
        n_t = (ptrdiff_t)1;
        k_t = (ptrdiff_t)EE_mat->size[1];
        lda_t = (ptrdiff_t)EE_mat->size[0];
        ldb_t = (ptrdiff_t)EE_mat->size[1];
        ldc_t = (ptrdiff_t)EE_mat->size[0];
        i0 = g_e->size[0];
        g_e->size[0] = EE_mat->size[0];
        emxEnsureCapacity_real_T1(&c_st, g_e, i0, &cf_emlrtRTEI);
        dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &ndbl, &EE_mat->data[0],
              &lda_t, &s->data[0], &ldb_t, &cdiff, &g_e->data[0], &ldc_t);
      }
    }

    st.site = &y_emlrtRSI;
    b_st.site = &oc_emlrtRSI;
    if (!(IE_mat->size[1] == s->size[0])) {
      if (((IE_mat->size[0] == 1) && (IE_mat->size[1] == 1)) || (s->size[0] == 1))
      {
        emlrtErrorWithMessageIdR2018a(&b_st, &th_emlrtRTEI,
          "Coder:toolbox:mtimes_noDynamicScalarExpansion",
          "Coder:toolbox:mtimes_noDynamicScalarExpansion", 0);
      } else {
        emlrtErrorWithMessageIdR2018a(&b_st, &uh_emlrtRTEI,
          "Coder:MATLAB:innerdim", "Coder:MATLAB:innerdim", 0);
      }
    }

    if ((IE_mat->size[1] == 1) || (s->size[0] == 1)) {
      i0 = r8->size[0];
      r8->size[0] = IE_mat->size[0];
      emxEnsureCapacity_real_T1(&st, r8, i0, &bf_emlrtRTEI);
      loop_ub = IE_mat->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r8->data[i0] = 0.0;
        nm1d2 = IE_mat->size[1];
        for (idx = 0; idx < nm1d2; idx++) {
          r8->data[i0] += IE_mat->data[i0 + IE_mat->size[0] * idx] * s->data[idx];
        }
      }
    } else {
      b_st.site = &nc_emlrtRSI;
      if ((IE_mat->size[0] == 0) || (IE_mat->size[1] == 0) || (s->size[0] == 0))
      {
        i0 = r8->size[0];
        r8->size[0] = IE_mat->size[0];
        emxEnsureCapacity_real_T1(&b_st, r8, i0, &bf_emlrtRTEI);
        loop_ub = IE_mat->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          r8->data[i0] = 0.0;
        }
      } else {
        c_st.site = &pc_emlrtRSI;
        c_st.site = &qc_emlrtRSI;
        TRANSA = 'N';
        TRANSB = 'N';
        ndbl = 1.0;
        cdiff = 0.0;
        m_t = (ptrdiff_t)IE_mat->size[0];
        n_t = (ptrdiff_t)1;
        k_t = (ptrdiff_t)IE_mat->size[1];
        lda_t = (ptrdiff_t)IE_mat->size[0];
        ldb_t = (ptrdiff_t)IE_mat->size[1];
        ldc_t = (ptrdiff_t)IE_mat->size[0];
        i0 = r8->size[0];
        r8->size[0] = IE_mat->size[0];
        emxEnsureCapacity_real_T1(&c_st, r8, i0, &cf_emlrtRTEI);
        dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &ndbl, &IE_mat->data[0],
              &lda_t, &s->data[0], &ldb_t, &cdiff, &r8->data[0], &ldc_t);
      }
    }

    i0 = g_e->size[0];
    idx = r8->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &n_emlrtECI, sp);
    }

    i0 = g_e->size[0];
    emxEnsureCapacity_real_T1(sp, g_e, i0, &ef_emlrtRTEI);
    loop_ub = g_e->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      g_e->data[i0] += r8->data[i0];
    }

    st.site = &ab_emlrtRSI;
    b_st.site = &oc_emlrtRSI;
    if (!(II_mat->size[1] == s->size[0])) {
      if (((II_mat->size[0] == 1) && (II_mat->size[1] == 1)) || (s->size[0] == 1))
      {
        emlrtErrorWithMessageIdR2018a(&b_st, &th_emlrtRTEI,
          "Coder:toolbox:mtimes_noDynamicScalarExpansion",
          "Coder:toolbox:mtimes_noDynamicScalarExpansion", 0);
      } else {
        emlrtErrorWithMessageIdR2018a(&b_st, &uh_emlrtRTEI,
          "Coder:MATLAB:innerdim", "Coder:MATLAB:innerdim", 0);
      }
    }

    if ((II_mat->size[1] == 1) || (s->size[0] == 1)) {
      i0 = g_i->size[0];
      g_i->size[0] = II_mat->size[0];
      emxEnsureCapacity_real_T1(&st, g_i, i0, &if_emlrtRTEI);
      loop_ub = II_mat->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        g_i->data[i0] = 0.0;
        nm1d2 = II_mat->size[1];
        for (idx = 0; idx < nm1d2; idx++) {
          g_i->data[i0] += II_mat->data[i0 + II_mat->size[0] * idx] * s->
            data[idx];
        }
      }
    } else {
      b_st.site = &nc_emlrtRSI;
      if ((II_mat->size[0] == 0) || (II_mat->size[1] == 0) || (s->size[0] == 0))
      {
        i0 = g_i->size[0];
        g_i->size[0] = II_mat->size[0];
        emxEnsureCapacity_real_T1(&b_st, g_i, i0, &if_emlrtRTEI);
        loop_ub = II_mat->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          g_i->data[i0] = 0.0;
        }
      } else {
        c_st.site = &pc_emlrtRSI;
        c_st.site = &qc_emlrtRSI;
        TRANSA = 'N';
        TRANSB = 'N';
        ndbl = 1.0;
        cdiff = 0.0;
        m_t = (ptrdiff_t)II_mat->size[0];
        n_t = (ptrdiff_t)1;
        k_t = (ptrdiff_t)II_mat->size[1];
        lda_t = (ptrdiff_t)II_mat->size[0];
        ldb_t = (ptrdiff_t)II_mat->size[1];
        ldc_t = (ptrdiff_t)II_mat->size[0];
        i0 = g_i->size[0];
        g_i->size[0] = II_mat->size[0];
        emxEnsureCapacity_real_T1(&c_st, g_i, i0, &cf_emlrtRTEI);
        dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &ndbl, &II_mat->data[0],
              &lda_t, &s->data[0], &ldb_t, &cdiff, &g_i->data[0], &ldc_t);
      }
    }

    st.site = &ab_emlrtRSI;
    b_st.site = &oc_emlrtRSI;
    if (!(EI_mat->size[1] == s->size[0])) {
      if (((EI_mat->size[0] == 1) && (EI_mat->size[1] == 1)) || (s->size[0] == 1))
      {
        emlrtErrorWithMessageIdR2018a(&b_st, &th_emlrtRTEI,
          "Coder:toolbox:mtimes_noDynamicScalarExpansion",
          "Coder:toolbox:mtimes_noDynamicScalarExpansion", 0);
      } else {
        emlrtErrorWithMessageIdR2018a(&b_st, &uh_emlrtRTEI,
          "Coder:MATLAB:innerdim", "Coder:MATLAB:innerdim", 0);
      }
    }

    if ((EI_mat->size[1] == 1) || (s->size[0] == 1)) {
      i0 = r8->size[0];
      r8->size[0] = EI_mat->size[0];
      emxEnsureCapacity_real_T1(&st, r8, i0, &mf_emlrtRTEI);
      loop_ub = EI_mat->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        r8->data[i0] = 0.0;
        nm1d2 = EI_mat->size[1];
        for (idx = 0; idx < nm1d2; idx++) {
          r8->data[i0] += EI_mat->data[i0 + EI_mat->size[0] * idx] * s->data[idx];
        }
      }
    } else {
      b_st.site = &nc_emlrtRSI;
      if ((EI_mat->size[0] == 0) || (EI_mat->size[1] == 0) || (s->size[0] == 0))
      {
        i0 = r8->size[0];
        r8->size[0] = EI_mat->size[0];
        emxEnsureCapacity_real_T1(&b_st, r8, i0, &mf_emlrtRTEI);
        loop_ub = EI_mat->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          r8->data[i0] = 0.0;
        }
      } else {
        c_st.site = &pc_emlrtRSI;
        c_st.site = &qc_emlrtRSI;
        TRANSA = 'N';
        TRANSB = 'N';
        ndbl = 1.0;
        cdiff = 0.0;
        m_t = (ptrdiff_t)EI_mat->size[0];
        n_t = (ptrdiff_t)1;
        k_t = (ptrdiff_t)EI_mat->size[1];
        lda_t = (ptrdiff_t)EI_mat->size[0];
        ldb_t = (ptrdiff_t)EI_mat->size[1];
        ldc_t = (ptrdiff_t)EI_mat->size[0];
        i0 = r8->size[0];
        r8->size[0] = EI_mat->size[0];
        emxEnsureCapacity_real_T1(&c_st, r8, i0, &cf_emlrtRTEI);
        dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &ndbl, &EI_mat->data[0],
              &lda_t, &s->data[0], &ldb_t, &cdiff, &r8->data[0], &ldc_t);
      }
    }

    i0 = g_i->size[0];
    idx = r8->size[0];
    if (i0 != idx) {
      emlrtSizeEqCheck1DR2012b(i0, idx, &m_emlrtECI, sp);
    }

    i0 = g_i->size[0];
    emxEnsureCapacity_real_T1(sp, g_i, i0, &nf_emlrtRTEI);
    loop_ub = g_i->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      g_i->data[i0] += r8->data[i0];
    }

    /*     %% Add data to the output variables */
    /* Question: is accessing structure slower than doubles? */
    if ((c_mod(-0.0 - dt) == 0.0) && (-0.0 - dt >= 0.0)) {
      i0 = recordVALs->size[1];
      idx = tt + 1;
      if (!((idx >= 1) && (idx <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &ab_emlrtBCI, sp);
      }

      st.site = &bb_emlrtRSI;
      toLogicalCheck(&st, recordVALs->data[tt]);
      if (recordVALs->data[tt] != 0.0) {
        i0 = SimValues->t->size[1];
        idx = (int32_T)savecounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &gc_emlrtBCI, sp);
        }

        SimValues->t->data[idx - 1] = -0.0 - dt;
        loop_ub = SimValues->V->size[0];
        i0 = ii->size[0];
        ii->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, ii, i0, &qf_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          ii->data[i0] = i0;
        }

        i0 = SimValues->V->size[1];
        idx = (int32_T)savecounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &x_emlrtBCI, sp);
        }

        d_ii[0] = ii->size[0];
        emlrtSubAssignSizeCheckR2012b(&d_ii[0], 1, &(*(int32_T (*)[1])V->size)[0],
          1, &i_emlrtECI, sp);
        loop_ub = V->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          SimValues->V->data[ii->data[i0] + SimValues->V->size[0] * ((int32_T)
            savecounter - 1)] = V->data[i0];
        }

        loop_ub = SimValues->g_w->size[0];
        i0 = ii->size[0];
        ii->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, ii, i0, &rf_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          ii->data[i0] = i0;
        }

        i0 = SimValues->g_w->size[1];
        idx = (int32_T)savecounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &w_emlrtBCI, sp);
        }

        d_ii[0] = ii->size[0];
        emlrtSubAssignSizeCheckR2012b(&d_ii[0], 1, &(*(int32_T (*)[1])g_w->size)
          [0], 1, &h_emlrtECI, sp);
        loop_ub = g_w->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          SimValues->g_w->data[ii->data[i0] + SimValues->g_w->size[0] *
            ((int32_T)savecounter - 1)] = g_w->data[i0];
        }

        loop_ub = SimValues->g_e->size[0];
        i0 = ii->size[0];
        ii->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, ii, i0, &tf_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          ii->data[i0] = i0;
        }

        i0 = SimValues->g_e->size[1];
        idx = (int32_T)savecounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &v_emlrtBCI, sp);
        }

        d_ii[0] = ii->size[0];
        emlrtSubAssignSizeCheckR2012b(&d_ii[0], 1, &(*(int32_T (*)[1])g_e->size)
          [0], 1, &g_emlrtECI, sp);
        loop_ub = g_e->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          SimValues->g_e->data[ii->data[i0] + SimValues->g_e->size[0] *
            ((int32_T)savecounter - 1)] = g_e->data[i0];
        }

        loop_ub = SimValues->g_i->size[0];
        i0 = ii->size[0];
        ii->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, ii, i0, &wf_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          ii->data[i0] = i0;
        }

        i0 = SimValues->g_i->size[1];
        idx = (int32_T)savecounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &u_emlrtBCI, sp);
        }

        d_ii[0] = ii->size[0];
        emlrtSubAssignSizeCheckR2012b(&d_ii[0], 1, &(*(int32_T (*)[1])g_i->size)
          [0], 1, &f_emlrtECI, sp);
        loop_ub = g_i->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          SimValues->g_i->data[ii->data[i0] + SimValues->g_i->size[0] *
            ((int32_T)savecounter - 1)] = g_i->data[i0];
        }

        loop_ub = SimValues->s->size[0];
        i0 = ii->size[0];
        ii->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, ii, i0, &xf_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          ii->data[i0] = i0;
        }

        i0 = SimValues->s->size[1];
        idx = (int32_T)savecounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &t_emlrtBCI, sp);
        }

        d_ii[0] = ii->size[0];
        emlrtSubAssignSizeCheckR2012b(&d_ii[0], 1, &(*(int32_T (*)[1])s->size)[0],
          1, &e_emlrtECI, sp);
        loop_ub = s->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          SimValues->s->data[ii->data[i0] + SimValues->s->size[0] * ((int32_T)
            savecounter - 1)] = s->data[i0];
        }

        loop_ub = SimValues->w->size[0];
        i0 = ii->size[0];
        ii->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, ii, i0, &ag_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          ii->data[i0] = i0;
        }

        i0 = SimValues->w->size[1];
        idx = (int32_T)savecounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &s_emlrtBCI, sp);
        }

        d_ii[0] = ii->size[0];
        emlrtSubAssignSizeCheckR2012b(&d_ii[0], 1, &(*(int32_T (*)[1])w->size)[0],
          1, &d_emlrtECI, sp);
        loop_ub = w->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          SimValues->w->data[ii->data[i0] + SimValues->w->size[0] * ((int32_T)
            savecounter - 1)] = w->data[i0];
        }

        loop_ub = SimValues->a_w->size[0];
        i0 = ii->size[0];
        ii->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, ii, i0, &bg_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          ii->data[i0] = i0;
        }

        i0 = SimValues->a_w->size[1];
        idx = (int32_T)savecounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &r_emlrtBCI, sp);
        }

        d_ii[0] = ii->size[0];
        emlrtSubAssignSizeCheckR2012b(&d_ii[0], 1, &(*(int32_T (*)[1])a_w->size)
          [0], 1, &c_emlrtECI, sp);
        loop_ub = a_w->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          SimValues->a_w->data[ii->data[i0] + SimValues->a_w->size[0] *
            ((int32_T)savecounter - 1)] = a_w->data[i0];
        }

        i0 = I_e->size[0];
        idx = X_t->size[0];
        if (i0 != idx) {
          emlrtSizeEqCheck1DR2012b(i0, idx, &l_emlrtECI, sp);
        }

        loop_ub = SimValues->Input->size[0];
        i0 = ii->size[0];
        ii->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, ii, i0, &dg_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          ii->data[i0] = i0;
        }

        i0 = SimValues->Input->size[1];
        idx = (int32_T)savecounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &q_emlrtBCI, sp);
        }

        d_ii[0] = ii->size[0];
        emlrtSubAssignSizeCheckR2012b(&d_ii[0], 1, &(*(int32_T (*)[1])I_e->size)
          [0], 1, &b_emlrtECI, sp);
        loop_ub = I_e->size[0];
        for (i0 = 0; i0 < loop_ub; i0++) {
          SimValues->Input->data[ii->data[i0] + SimValues->Input->size[0] *
            ((int32_T)savecounter - 1)] = I_e->data[i0] + X_t->data[i0];
        }

        savecounter++;
      }
    }

    /* Save the weights (less frequently for space concerns) */
    if ((d_mod(-0.0 - dt) == 0.0) && (-0.0 - dt >= 0.0)) {
      i0 = recordVALs->size[1];
      idx = tt + 1;
      if (!((idx >= 1) && (idx <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &y_emlrtBCI, sp);
      }

      st.site = &cb_emlrtRSI;
      toLogicalCheck(&st, recordVALs->data[tt]);
      if (recordVALs->data[tt] != 0.0) {
        i0 = SimValues->t_weight->size[1];
        idx = (int32_T)weightcounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &hc_emlrtBCI, sp);
        }

        SimValues->t_weight->data[idx - 1] = -0.0 - dt;
        for (i0 = 0; i0 < 2; i0++) {
          b_EE_mat[i0] = EE_mat->size[i0];
        }

        for (i0 = 0; i0 < 2; i0++) {
          b_ii[i0] = II_mat->size[i0];
        }

        if ((b_EE_mat[0] != b_ii[0]) || (b_EE_mat[1] != b_ii[1])) {
          emlrtSizeEqCheckNDR2012b(&b_EE_mat[0], &b_ii[0], &k_emlrtECI, sp);
        }

        for (i0 = 0; i0 < 2; i0++) {
          b_EE_mat[i0] = EE_mat->size[i0];
        }

        for (i0 = 0; i0 < 2; i0++) {
          c_EI_mat[i0] = EI_mat->size[i0];
        }

        if ((b_EE_mat[0] != c_EI_mat[0]) || (b_EE_mat[1] != c_EI_mat[1])) {
          emlrtSizeEqCheckNDR2012b(&b_EE_mat[0], &c_EI_mat[0], &k_emlrtECI, sp);
        }

        for (i0 = 0; i0 < 2; i0++) {
          b_EE_mat[i0] = EE_mat->size[i0];
        }

        for (i0 = 0; i0 < 2; i0++) {
          b_ii[i0] = IE_mat->size[i0];
        }

        if ((b_EE_mat[0] != b_ii[0]) || (b_EE_mat[1] != b_ii[1])) {
          emlrtSizeEqCheckNDR2012b(&b_EE_mat[0], &b_ii[0], &k_emlrtECI, sp);
        }

        loop_ub = SimValues->WeightMat->size[0];
        i0 = ii->size[0];
        ii->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, ii, i0, &sf_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          ii->data[i0] = i0;
        }

        loop_ub = SimValues->WeightMat->size[1];
        i0 = r3->size[0];
        r3->size[0] = loop_ub;
        emxEnsureCapacity_int32_T(sp, r3, i0, &uf_emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          r3->data[i0] = i0;
        }

        i0 = SimValues->WeightMat->size[2];
        idx = (int32_T)weightcounter;
        if (!((idx >= 1) && (idx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, i0, &p_emlrtBCI, sp);
        }

        b_ii[0] = ii->size[0];
        b_ii[1] = r3->size[0];
        emlrtSubAssignSizeCheckR2012b(&b_ii[0], 2, &(*(int32_T (*)[2])
          EE_mat->size)[0], 2, &emlrtECI, sp);
        loop_ub = EE_mat->size[1];
        for (i0 = 0; i0 < loop_ub; i0++) {
          nm1d2 = EE_mat->size[0];
          for (idx = 0; idx < nm1d2; idx++) {
            SimValues->WeightMat->data[(ii->data[idx] + SimValues->
              WeightMat->size[0] * r3->data[i0]) + SimValues->WeightMat->size[0]
              * SimValues->WeightMat->size[1] * ((int32_T)weightcounter - 1)] =
              ((EE_mat->data[idx + EE_mat->size[0] * i0] + II_mat->data[idx +
                II_mat->size[0] * i0]) + EI_mat->data[idx + EI_mat->size[0] * i0])
              + IE_mat->data[idx + IE_mat->size[0] * i0];
          }
        }

        weightcounter++;
      }
    }

    /* Idea: add a catch for silent network or excessive firing network? */
    tt++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(sp, &b_EI_mat);
  emxFree_boolean_T(sp, &b_sigma);
  emxFree_real_T(sp, &r7);
  emxFree_real_T(sp, &b_w_r);
  emxFree_int32_T(sp, &ii);
  emxFree_int32_T(sp, &r21);
  emxFree_int32_T(sp, &r20);
  emxFree_int32_T(sp, &r19);
  emxFree_int32_T(sp, &r18);
  emxFree_int32_T(sp, &r17);
  emxFree_int32_T(sp, &r16);
  emxFree_int32_T(sp, &r15);
  emxFree_int32_T(sp, &r14);
  emxFree_int32_T(sp, &r13);
  emxFree_int32_T(sp, &r12);
  emxFree_real32_T(sp, &r11);
  emxFree_real_T(sp, &r10);
  emxFree_real_T(sp, &r8);
  emxFree_int32_T(sp, &r4);
  emxFree_int32_T(sp, &r3);
  emxFree_real_T(sp, &r1);
  emxFree_real_T(sp, &r0);
  emxFree_real_T(sp, &PostEspikes);
  emxFree_real_T(sp, &PreIspikes);
  emxFree_real_T(sp, &dX);
  emxFree_real_T(sp, &b_x);
  emxFree_real_T(sp, &t_r);
  emxFree_real_T(sp, &X_t);
  emxFree_real_T(sp, &w);
  emxFree_real_T(sp, &s);
  emxFree_real_T(sp, &a_w);
  emxFree_real_T(sp, &g_w);
  emxFree_real_T(sp, &g_i);
  emxFree_real_T(sp, &g_e);
  emxFree_real_T(sp, &V);
  emxFree_real_T(sp, &alpha);
  emxFree_real_T(sp, &tauSTDP);
  emxFree_real_T(sp, &ILearningRate);
  emxFree_real_T(sp, &ELearningRate);
  emxFree_real_T(sp, &tau_s);
  emxFree_real_T(sp, &E_i);
  emxFree_real_T(sp, &E_e);
  emxFree_real_T(sp, &b);
  emxFree_real_T(sp, &w_r);
  emxFree_real_T(sp, &gwnorm);
  emxFree_real_T(sp, &delta_T);
  emxFree_real_T(sp, &b_w);
  emxFree_real_T(sp, &E_w);
  emxFree_real_T(sp, &theta);
  emxFree_real_T(sp, &sigma);
  emxFree_real_T(sp, &t_ref);
  emxFree_real_T(sp, &V_reset);
  emxFree_real_T(sp, &V_th);
  emxFree_real_T(sp, &I_e);
  emxFree_real_T(sp, &C);
  emxFree_real_T(sp, &g_L);
  emxFree_real_T(sp, &E_L);
  emxFree_boolean_T(sp, &isconnected);
  emxFree_boolean_T(sp, &IcellIDX);
  emxFree_boolean_T(sp, &EcellIDX);
  emxFree_real_T(sp, &EI_mat);
  emxFree_real_T(sp, &IE_mat);
  emxFree_real_T(sp, &II_mat);
  emxFree_real_T(sp, &EE_mat);
  emxFree_real_T(sp, &recordVALs);

  /*  */
  /* Catch for no spiking in simulation error */
  i0 = spikes->size[0];
  idx = r22->size[0] * r22->size[1];
  r22->size[0] = 1;
  r22->size[1] = (int32_T)((real_T)i0 - (absa + 1.0)) + 1;
  emxEnsureCapacity_int32_T1(sp, r22, idx, &md_emlrtRTEI);
  loop_ub = (int32_T)((real_T)i0 - (absa + 1.0));
  for (i0 = 0; i0 <= loop_ub; i0++) {
    r22->data[r22->size[0] * i0] = (int32_T)((absa + 1.0) + (real_T)i0);
  }

  st.site = &eb_emlrtRSI;
  nullAssignment(&st, spikes, r22);

  /* if isempty(spikes); spikes = [nan nan]; end */
  /*  Figure */
  st.site = &db_emlrtRSI;
  ndbl = randi(PopNum);
  loop_ub = spikes->size[0];
  i0 = x->size[0];
  x->size[0] = loop_ub;
  emxEnsureCapacity_boolean_T1(sp, x, i0, &pd_emlrtRTEI);
  emxFree_int32_T(sp, &r22);
  for (i0 = 0; i0 < loop_ub; i0++) {
    x->data[i0] = (spikes->data[i0 + spikes->size[0]] == ndbl);
  }

  nx = x->size[0];
  for (idx = 0; idx < nx; idx++) {
    if (x->data[idx]) {
      i0 = spikes->size[0];
      if (!((idx + 1 >= 1) && (idx + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(idx + 1, 1, i0, &j_emlrtBCI, sp);
      }
    }
  }

  emxInit_real32_T1(sp, &b_spikes, 1, &td_emlrtRTEI, true);
  st.site = &bd_emlrtRSI;
  figure(&st, &emlrtMCI);
  y = NULL;
  m0 = emlrtCreateCharArray(2, iv0);
  emlrtInitCharArrayR2013a(sp, 2, m0, &u[0]);
  emlrtAssign(&y, m0);
  b_y = NULL;
  m0 = emlrtCreateCharArray(2, iv1);
  emlrtInitCharArrayR2013a(sp, 10, m0, &b_u[0]);
  emlrtAssign(&b_y, m0);
  c_y = NULL;
  m0 = emlrtCreateDoubleScalar(0.1);
  emlrtAssign(&c_y, m0);
  loop_ub = spikes->size[0];
  i0 = b_spikes->size[0];
  b_spikes->size[0] = loop_ub;
  emxEnsureCapacity_real32_T1(sp, b_spikes, i0, &td_emlrtRTEI);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_spikes->data[i0] = spikes->data[i0];
  }

  emxInit_real32_T1(sp, &c_spikes, 1, &wd_emlrtRTEI, true);
  loop_ub = spikes->size[0];
  i0 = c_spikes->size[0];
  c_spikes->size[0] = loop_ub;
  emxEnsureCapacity_real32_T1(sp, c_spikes, i0, &wd_emlrtRTEI);
  for (i0 = 0; i0 < loop_ub; i0++) {
    c_spikes->data[i0] = spikes->data[i0 + spikes->size[0]];
  }

  st.site = &cd_emlrtRSI;
  plot(&st, emlrt_marshallOut(b_spikes), emlrt_marshallOut(c_spikes), y, b_y,
       c_y, &b_emlrtMCI);
  y = NULL;
  m0 = emlrtCreateCharArray(2, iv2);
  emlrtInitCharArrayR2013a(sp, 2, m0, &c_u[0]);
  emlrtAssign(&y, m0);
  st.site = &dd_emlrtRSI;
  hold(&st, y, &c_emlrtMCI);
  y = NULL;
  m0 = emlrtCreateString1('r');
  emlrtAssign(&y, m0);
  emxFree_real32_T(sp, &c_spikes);
  emxFree_real32_T(sp, &b_spikes);
  for (i0 = 0; i0 < 2; i0++) {
    V0range[i0] = 0.0;
  }

  dv1[0] = 0.0;
  dv1[1] = PopNum;
  st.site = &ed_emlrtRSI;
  b_plot(&st, b_emlrt_marshallOut(V0range), b_emlrt_marshallOut(dv1), y,
         &d_emlrtMCI);
  y = NULL;
  m0 = emlrtCreateCharArray(2, iv3);
  emlrtInitCharArrayR2013a(sp, 9, m0, &d_u[0]);
  emlrtAssign(&y, m0);
  st.site = &fd_emlrtRSI;
  xlabel(&st, y, &e_emlrtMCI);
  y = NULL;
  m0 = emlrtCreateCharArray(2, iv4);
  emlrtInitCharArrayR2013a(sp, 9, m0, &e_u[0]);
  emlrtAssign(&y, m0);
  st.site = &fd_emlrtRSI;
  ylabel(&st, y, &f_emlrtMCI);
  y = NULL;
  m0 = emlrtCreateCharArray(2, iv5);
  emlrtInitCharArrayR2013a(sp, 11, m0, &f_u[0]);
  emlrtAssign(&y, m0);
  st.site = &fd_emlrtRSI;
  title(&st, y, &g_emlrtMCI);
  V0range[0] = -0.0;
  V0range[1] = TimeParams->SimTime;
  st.site = &gd_emlrtRSI;
  xlim(&st, b_emlrt_marshallOut(V0range), &h_emlrtMCI);
  V0range[0] = 0.0;
  V0range[1] = PopNum + 1.0;
  st.site = &gd_emlrtRSI;
  ylim(&st, b_emlrt_marshallOut(V0range), &i_emlrtMCI);

  /*  Output Structure */
  /* Remove onset time */
  loop_ub = spikes->size[0];
  i0 = x->size[0];
  x->size[0] = loop_ub;
  emxEnsureCapacity_boolean_T1(sp, x, i0, &ee_emlrtRTEI);
  for (i0 = 0; i0 < loop_ub; i0++) {
    x->data[i0] = (spikes->data[i0] <= 0.0F);
  }

  st.site = &fb_emlrtRSI;
  b_nullAssignment(&st, spikes, x);

  /* if cellout */
  /*     for cc = 1:PopNum %This can go very slow with lots of spikes.... */
  /*         spikesbycell{cc} = spikes(spikes(:,2)==cc,1); */
  /*     end */
  /*     SimValues.spikesbycell    = spikesbycell; */
  /* end */
  i0 = SimValues->spikes->size[0] * SimValues->spikes->size[1];
  SimValues->spikes->size[0] = spikes->size[0];
  SimValues->spikes->size[1] = 2;
  emxEnsureCapacity_real32_T(sp, SimValues->spikes, i0, &ie_emlrtRTEI);
  loop_ub = spikes->size[0] * spikes->size[1];
  emxFree_boolean_T(sp, &x);
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->spikes->data[i0] = spikes->data[i0];
  }

  emxFree_real32_T(sp, &spikes);
  i0 = SimValues->EcellIDX->size[0] * SimValues->EcellIDX->size[1];
  SimValues->EcellIDX->size[0] = 1;
  SimValues->EcellIDX->size[1] = Ecells->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->EcellIDX, i0, &ke_emlrtRTEI);
  loop_ub = Ecells->size[0] * Ecells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->EcellIDX->data[i0] = Ecells->data[i0];
  }

  emxFree_real_T(sp, &Ecells);
  i0 = SimValues->IcellIDX->size[0] * SimValues->IcellIDX->size[1];
  SimValues->IcellIDX->size[0] = 1;
  SimValues->IcellIDX->size[1] = Icells->size[1];
  emxEnsureCapacity_real_T(sp, SimValues->IcellIDX, i0, &ne_emlrtRTEI);
  loop_ub = Icells->size[0] * Icells->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    SimValues->IcellIDX->data[i0] = Icells->data[i0];
  }

  emxFree_real_T(sp, &Icells);

  /* SimValues.WeightMat       = EE_mat+II_mat+EI_mat+IE_mat; */
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (CAdLIFfunction_STDP.c) */
