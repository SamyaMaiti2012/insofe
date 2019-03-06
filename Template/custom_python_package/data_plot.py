import matplotlib.pyplot as plt     
import matplotlib.ticker as ticker
import seaborn as sns



def plot_data_dist_across_targ(dataF, target):
    """
    Plot target variable distribution
    """
    
    print(dataF[target].value_counts())
    print((dataF[target].value_counts()/dataF[target].count())*100)
    
    plt.figure(figsize=(12,4))
    plt.style.use('seaborn-ticks')
    plot_1 = sns.countplot(y=target, data=dataF, order = dataF[target].value_counts().index);
    plot_1.axes.set_title("Target Variable Distribution",fontsize=20);
    plot_1.set_xlabel("Count",fontsize=20);
    plot_1.set_ylabel("Target Variable",fontsize=20);
    plot_1.tick_params(labelsize=15);
    plt.show();
    
    

def get_correlation_plot(dataF):
    corr = dataF.corr()
    f, ax = plt.subplots(figsize=(16, 10))
    sns.heatmap(corr, ax=ax, annot=True, cmap="YlGnBu");
    
    
def distribution_of_var(dataF):
    plt.figure(figsize=(18,9));
    plt.title("Distribution of all variables");
    plt.ylabel("Range of values on Strandard normal scale")
    plt.xlabel("Variables")
    dataF.boxplot(rot=90);

    
    
def draw_pair_plot(dataF, target):
    g = sns.PairGrid(dataF, hue=target)
    g.map_diag(plt.hist)
    g.map_offdiag(plt.scatter);

    

def draw_pca_plot(dataF):
    fig = plt.gcf()
    fig.set_size_inches( 16, 8)
    sns.set(font_scale = .7)
    dataF_line_plot = sns.lineplot(x="Number of PC", y="Cumulative Sum of variance", data=dataF)
    dataF_line_plot.xaxis.set_major_locator(ticker.MultipleLocator(1))
    dataF_line_plot.xaxis.set_major_formatter(ticker.ScalarFormatter())
    plt.show()


