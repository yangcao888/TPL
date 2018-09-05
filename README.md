# Papers

Quantifying Differential Privacy under Temporal Correlations (ICDE17) 
https://arxiv.org/abs/1610.07543

    @inproceedings{cao2017quantifying,
      title={Quantifying differential privacy under temporal correlations},
      author={Cao, Yang and Yoshikawa, Masatoshi and Xiao, Yonghui and Xiong, Li},
      booktitle={Data Engineering (ICDE), 2017 IEEE 33rd International Conference on},
      pages={821--832},
      year={2017},
      organization={IEEE}
    }


Quantifying Differential Privacy in Continuous Data Release under Temporal Correlations (Invited for TKDE special issue on "Best of ICDE 2017") https://arxiv.org/abs/1711.11436

    @article{cao2018quantifying,
      title={Quantifying Differential Privacy in Continuous Data Release under Temporal Correlations},
      author={Cao, Yang and Yoshikawa, Masatoshi and Xiao, Yonghui and Xiong, Li},
      journal={IEEE Transactions on Knowledge and Data Engineering},
      year={2018},
      publisher={IEEE}
    }
    
ConTPL: Controlling Temporal Privacy Leakage in Differentially Private Continuous Data Release (VLDB18 demo) 
http://www.vldb.org/pvldb/vol11/p2090-cao.pdf

    @article{cao2018ConTPL,
      title={ConTPL: Controlling Temporal Privacy Leakage in Differentially Private Continuous Data Release},
      author={Yang Cao, Li Xiong, Masatoshi Yoshikawa, Yonghui Xiao, Si Zhang},
      journal={PVLDB 11(12)},
      year={2018},
      pages={2090--2093}
    }
    

# Environment
- Matlab2017b.
- CPLEX (optional)
- Gurobi (optional)

Function `calcPLbyLP_cplex` needs IBM CPLEX. Function `calcPLbyLP_gu` needs Gurobi.
You can find (free) academics version of CPLEX or Gruobi.
Alternatively, you can use Matlab linear program solver rather than CPLEX or Gurobi by invoking `calcPLbyLP(TM, a, 'matlab')`. Tip: you can take a sleep if using Matlab linear program solver for n>30 :P

### tips for downloading and installing CPLEX:
1. Download CPLEX [academic version](https://developer.ibm.com/docloud/blog/2016/11/24/cos-12-7-ai/) (I use this version)   or [free trial version](https://www.ibm.com/developerworks/downloads/ws/ilogcplex/#) (the free trial period is 90 days).  Here are the descriptions on the [differences between these versions](https://www-01.ibm.com/software/websphere/products/optimization/cplex-studio-community-edition/). 
2. Install CPLEX. 
3. Setting up CPLEX for Matlab, refer to [here](https://www.ibm.com/support/knowledgecenter/SSSA5P_12.7.1/ilog.odms.cplex.help/CPLEX/MATLAB/topics/gs_install.html).

# Overview
![alt overview](/TPL_uml.png)

# Test scripts

- `testPlotLFunc.m` plotting an example of L(a) function
- `testPlotBudgetAlloc.m` plotting two examples of budget allocation schemes and the corresponding BPL/FPL/TPL.
- `testCalcBPL.m` running `calcPLbyLP`, `calcPLbyThm`, `calcPLbyPreComp` and `calcPLbyFunc`, and outputing the results and runtime. Note that, the results are not BPL/FPL but L(a).
- `testFindSup.m` running `findSup` and comparing the result with step-by-step calculation.
 
# Main Functions

### budget allocation schemes
- `allocEspByQuantify` Allocating privacy budget by quantification.
- `allocEspByUpperBound` Allocating privacy budget by upper bound.

### privacy leakage quantification
- `calcPLbyLP` Calculating L(a) by Linear programming. input `method` can be set as 'gurobi' or 'cplex', or 'matlab'.
- `calcPLbyThm` Calculating L(a) by Theorem 4.
- `calcPLbyPreComp` Calculating L(a) by precomputation. inputs `EspMatrix`, `qM` and `dM` can be obtained by `preCompQDMatrix`.
- `calcPLbyFunc` Calculating L(a) by binary search. inputs `aArrMax`, `qArrMax` and `dArrMax` can be obtained by `genLFunc`.
 
### supremum of BPL/FPL
- `findSup` Calculating the suppremum of a DP mechanism M^t whose privacy budget is constant at each time t. inputs `qM`, `dM`, `QDplusInd` can be obtained by `preCompQDMatrix`.

### precomputation
- `preCompQDMatrix` Precomputing `EspMatrix`, `qM`, `dM` and `QDplusInd`.
- `genLFunc` Precomputing L(a) function, i.e., `aArrMax`, `qArrMax` and `dArrMax`.


# Contact

Yang Cao 
yang@i.kyoto-u.ac.jp

    
