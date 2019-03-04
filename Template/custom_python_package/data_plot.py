import matplotlib.pyplot as plt     
import matplotlib.ticker as ticker
import seaborn as sns



def plotDataDistAcrossTarg(dataF, target):
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
    
    
