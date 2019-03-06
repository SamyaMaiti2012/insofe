import matplotlib.pyplot as plt     
import matplotlib.ticker as ticker
import seaborn as sns
from sklearn.model_selection import learning_curve
import numpy as np
from sklearn.metrics import roc_curve, auc, accuracy_score,classification_report, recall_score,precision_score,precision_recall_curve,average_precision_score, silhouette_score,roc_curve, auc,confusion_matrix,mean_absolute_error,mean_squared_error,roc_auc_score,f1_score
from sklearn import tree
import graphviz




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


def plot_learning_curve(estimator, title, X, y, ylim=None, cv=None,
                        n_jobs=None, train_sizes=np.linspace(.1, 1.0, 5)):
    plt.figure(figsize = (8,8))
    plt.title(title)
    if ylim is not None:
        plt.ylim(*ylim)
    plt.xlabel("Training examples")
    plt.ylabel("Score")
    
    train_sizes, train_scores, test_scores = learning_curve(estimator, X, y, cv=cv, n_jobs=n_jobs, train_sizes=train_sizes)
    
    train_scores_mean = np.mean(train_scores, axis=1)
    train_scores_std = np.std(train_scores, axis=1)
    
    test_scores_mean = np.mean(test_scores, axis=1)
    test_scores_std = np.std(test_scores, axis=1)
    
    plt.grid()
    plt.fill_between(train_sizes, train_scores_mean - train_scores_std,
                     train_scores_mean + train_scores_std, alpha=0.1,
                     color="r")
    plt.fill_between(train_sizes, test_scores_mean - test_scores_std,
                     test_scores_mean + test_scores_std, alpha=0.1, color="g")
    plt.plot(train_sizes, train_scores_mean, 'o-', color="r",
             label="Training score")
    plt.plot(train_sizes, test_scores_mean, 'o-', color="b",
             label="Cross-validation score")

    plt.legend(loc="best")
    plt.show()



def plot_confusion_matrix(y, y_pred):
    lables = list(set(y))
    ax= plt.subplot()
    cm = confusion_matrix(y, y_pred,lables)
    sns.heatmap(cm, annot=True, ax = ax, cmap="YlGnBu");
    print(cm)
    
    ax.set_xlabel('Predicted labels');
    ax.set_ylabel('True labels');
    ax.set_title('Confusion Matrix');
    ax.xaxis.set_ticklabels(lables);
    ax.yaxis.set_ticklabels(lables);

    
    
def plot_precision_recall(y, y_pred_prob):
    plt.figure(figsize = (8,8))
    # calculate precision-recall curve
    precision, recall, thresholds = precision_recall_curve(y, y_pred_prob)
    # calculate average precision score
    ap = average_precision_score(y, y_pred_prob)
    print('ap=%.3f' % (ap))
    # plot the roc curve for the model
    plt.plot(recall, precision);
    # show the plot
    plt.show()    
    

def plot_precision_recall_vs_threshold(y, y_pred_prob):
    precision, recall, thresholds = precision_recall_curve(y, y_pred_prob)
    plt.figure(figsize=(8, 8))
    plt.title("Precision and Recall Scores as a function of the decision threshold")
    plt.plot(thresholds, precisions[:-1], "b--", label="Precision")
    plt.plot(thresholds, recalls[:-1], "g-", label="Recall")
    plt.ylabel("Score")
    plt.xlabel("Decision Threshold")
    plt.legend(loc='best')
    
    
    
    
def plot_ROC_AUC(y, y_pred_prob):
    
    fig, ax = plt.subplots(figsize = (16,8))

    fpr = dict()
    tpr = dict()
    roc_auc = dict()
    fpr, tpr, thre = roc_curve(y, y_pred_prob)
    roc_auc = auc(fpr, tpr)

    #ax.figure(figsize = (8,8))
    ax.plot(fpr, tpr)
    ax.set_xlim([-0.05, 1.05])
    ax.set_ylim([0.0, 1.05])
    ax.plot([0, 1], [0, 1], linestyle='--')
    ax.set_xlabel('False Positive Rate')
    ax.set_ylabel('True Positive Rate')
    ax.set_title('Receiver operating characteristic')

    n=10
    for i, threshold in enumerate(thre):
        if i % n == 0:
            ax.annotate(threshold.round(decimals=2), (fpr[i],tpr[i]))

    print(roc_auc_score(y, y_pred_prob));
    
    
    
def draw_scatter_plot_by_cat(dataF, target):
    fig, ax = plt.subplots()
    fig.set_size_inches( 16, 8)
    sns.scatterplot(x= dataF.iloc[:, 0], y=dataF.iloc[:, 1], data = dataF, hue=target, ax=ax)
    
    

    
def draw_violin_plot(dataF):
    fig, ax = plt.subplots()
    fig.set_size_inches( 16, 8)
    sns.violinplot(data=dataF, ax=ax)
    
    
    
def plot_tree(dataF, target ,model):
    dot_data = tree.export_graphviz(model, out_file=None, feature_names=dataF.columns,
                                    class_names=target, filled=True, rounded=True, special_characters=True) 
    graph = graphviz.Source(dot_data) 
    return graph
