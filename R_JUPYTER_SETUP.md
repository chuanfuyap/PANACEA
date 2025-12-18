# Running R in Jupyter Notebook

This guide explains how to set up and run R in Jupyter notebooks for use with the PANACEA pipeline.

## Prerequisites

- Anaconda or Miniconda installed
- R installed on your system (R 3.3.0 or later recommended)

## Installation Methods

### Method 1: Using Conda (Recommended)

The easiest way to set up R in Jupyter is through conda, which will handle all dependencies:

```bash
# Create a new environment with R and Jupyter
conda create -n r_jupyter python=3.9 jupyter r-base r-irkernel

# Activate the environment
conda activate r_jupyter

# Install IRkernel (if not already installed)
R -e "IRkernel::installspec(user = TRUE)"
```

### Method 2: Using Existing R Installation

If you already have R installed on your system, you can install IRkernel directly:

1. Install Jupyter (if not already installed):
```bash
pip install jupyter
```

2. Install IRkernel in R:
```R
# Open R console and run:
install.packages('IRkernel')
IRkernel::installspec(user = TRUE)
```

### Method 3: Installing in Existing PANACEA Environment

To add R support to your existing PANACEA environment:

```bash
# Activate your PANACEA environment
conda activate regintest_env  # or whatever you named your environment

# Install R and IRkernel
conda install r-base r-irkernel

# Register the R kernel with Jupyter
R -e "IRkernel::installspec(user = TRUE)"
```

## Verifying Installation

1. Start Jupyter Notebook:
```bash
jupyter notebook
```

2. When creating a new notebook, you should see "R" as one of the available kernel options.

3. Alternatively, check available kernels from command line:
```bash
jupyter kernelspec list
```

You should see `ir` (R kernel) in the list.

## Using R in Jupyter Notebooks

Once installed, you can:

1. Create a new R notebook by selecting "R" kernel when creating a new notebook
2. Run R code directly in cells
3. Install additional R packages as needed

### Example R Code in Jupyter

```R
# Install packages (first time only)
install.packages("ggplot2")
install.packages("dplyr")

# Load libraries
library(ggplot2)
library(dplyr)

# Your R code here
data <- read.csv("your_data.csv")
summary(data)
```

## Common Use Cases for PANACEA

R can be particularly useful for:

- Visualizing PCA projections and AGV distributions
- Creating Manhattan plots from GWAS results
- Statistical analysis of REGINTEST output
- Custom plots and visualizations of meta-analysis results
- Quality control checks and data exploration

### Example: Reading REGINTEST Output

```R
# Read REGINTEST results
results <- read.table("regintest_output.tsv", header=TRUE, sep="\t")

# Basic summary
summary(results)

# Manhattan plot example
library(ggplot2)
ggplot(results, aes(x=BP, y=-log10(P), color=CHR)) +
  geom_point() +
  theme_minimal() +
  labs(title="REGINTEST Results", x="Position", y="-log10(P)")
```

## Troubleshooting

### Kernel Not Appearing

If the R kernel doesn't appear in Jupyter:

1. Make sure IRkernel is installed:
```R
# In R console
if (!require("IRkernel")) install.packages("IRkernel")
IRkernel::installspec(user = TRUE)
```

2. Restart Jupyter Notebook completely

### Permission Issues

If you encounter permission errors during installation:

- Use `user = TRUE` in `installspec()` to install for current user only
- Or run with appropriate privileges if installing system-wide: `IRkernel::installspec()`

### Kernel Dies Immediately

If the R kernel starts but dies immediately:

1. Check R is properly installed: `which R`
2. Verify IRkernel installation: `R -e "packageVersion('IRkernel')"`
3. Check kernel logs: `jupyter notebook --debug`

## Additional Resources

- [IRkernel Documentation](https://irkernel.github.io/)
- [Jupyter Documentation](https://jupyter.org/documentation)
- [R for Data Science](https://r4ds.had.co.nz/)

## Integration with PANACEA Workflow

You can use R notebooks alongside the Python-based PANACEA pipeline:

1. Use the Python scripts (project_gnomad.py, regintest.py) for computation
2. Use R notebooks for visualization and downstream analysis
3. Share the same conda environment for seamless integration

Example combined workflow:
```bash
# Activate environment with both Python and R
conda create -n panacea_full python=3.9 hail=0.2 statsmodels=0.14.4 pandas=2.3.0 scipy=1.11.3 numpy=1.26.1 patsy=1.0.1 jupyter r-base r-irkernel
conda activate panacea_full

# Run Python-based analysis
python regintest.py [options]

# Start Jupyter for R-based visualization
jupyter notebook
```
