from IPython.core.interactiveshell import InteractiveShell
import warnings
from tqdm import tqdm

import pandas as pd
import numpy as np
import collections

import random
from string import ascii_letters
import math
import itertools
import os

from sklearn.model_selection import StratifiedKFold, KFold, cross_val_score, GridSearchCV, RepeatedKFold, learning_curve, ShuffleSplit
from sklearn.metrics import roc_curve, auc, accuracy_score,classification_report, recall_score,precision_score,precision_recall_curve,average_precision_score, silhouette_score,roc_curve, auc,confusion_matrix,mean_absolute_error,mean_squared_error,roc_auc_score,f1_score
from sklearn.preprocessing import binarize
from sklearn.ensemble import RandomForestClassifier, BaggingClassifier
from sklearn.cluster import KMeans
from sklearn import svm
from xgboost import XGBClassifier
from sklearn.preprocessing import PolynomialFeatures
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB

from mlxtend.classifier import StackingClassifier

from statsmodels.stats.outliers_influence import variance_inflation_factor




def set_env_var():
    InteractiveShell.ast_node_interactivity = "all"
    warnings.filterwarnings('ignore')
    os.environ['KMP_DUPLICATE_LIB_OK']='True'
    pd.set_option('display.max_rows', 60)
    pd.set_option('display.max_columns', 60)
    

    
def set_seed(seed):
    return random.seed(seed)

 

def data_importer_csv(data_path, na_values=[]):
    dataF = pd.read_csv(data_path, na_values=na_values)
    print("The number of Rows in the Data set  = "+str(dataF.shape[0]))
    print("The number of Columns in the data set = " +str(dataF.shape[1]))
    return dataF


def data_importer_xlsx(data_path, na_values=[]):
    dataF = pd.read_excel(data_path, na_values=na_values)
    print("The number of Rows in the Data set  = "+str(dataF.shape[0]))
    print("The number of Columns in the data set = " +str(dataF.shape[1]))
    return dataF


def data_description(dataF):
    print("The columns in the data set are : \n",list(dataF.columns))
    print("The data types of the columns are :\n\n",dataF.dtypes)
    
    
    
def get_null_count_per_attribute(dataF): 
    return pd.DataFrame({'total_missing': dataF.isnull().sum(), 
                         'perc_missing': (dataF.isnull().sum()/dataF.shape[0])*100}).sort_values(
        by=['perc_missing'], ascending=False)



def get_data_sample(dataF, num_sample=10):
    return pd.DataFrame(dataF.sample(num_sample))




def get_monotonically_incleasing_attributes(dataF):
    """
    """
    for col in dataF.columns :
        if(dataF[col].is_monotonic) :
            print("Column :", col, ": is Monotonically increasing")
    

    
def get_unique_value_count_per_attribute(dataF): 
    return pd.DataFrame((dataF.nunique()/dataF.shape[0])*100).rename(
        {0: 'perc_unique'}, axis=1).sort_values(by=['perc_unique'])



def get_frequency_of_attr_value(dataF):
    dataF_count = get_unique_value_count_per_attribute(dataF)
    dataF_count_col = dataF_count.reset_index()['index']
    return pd.DataFrame(dataF[dataF_count_col.tolist()].apply(pd.Series.value_counts))
    

    
def covert_var(dataF, conversion_type):
    if(conversion_type=="cat"):
        converted_dataF = dataF.astype('category', copy=True)
    if(conversion_type=="num"):
        converted_dataF = dataF.astype('float64', copy=True)
    return converted_dataF


    
def get_outlier_removed_by_sigma_dist(dataF, target, targetVal,dist):
    dataF_target = dataF[dataF[target]==targetVal]
    dataF_target_1 = dataF_target.drop(target, axis=1)
    dataF_target_Sigma = dataF_target_1[~((np.abs(((dataF_target_1 - dataF_target_1.mean())/dataF_target_1.std())) > dist).any(1))]
    return dataF_target_Sigma




def get_vif(dataF):
    vif = pd.DataFrame()
    dataF_vif = dataF.dropna()
    vif["VIF_Factor"] = [variance_inflation_factor(dataF_vif.values, i) for i in range(dataF_vif.shape[1])]
    vif["features"] = dataF_vif.columns
    return vif.sort_values('VIF_Factor', ascending=False)


def get_missing_value_by_row(dataF):
    dataF_cull_count_by_row = pd.DataFrame(dataF.isna().sum(axis=1)).rename({0:"count_of_null"}, axis=1).sort_values(
        by='count_of_null', ascending=False).assign(
        count_of_null_percent=lambda row:(row.count_of_null/dataF.shape[1])*100)
    return dataF_cull_count_by_row['count_of_null'].value_counts().sort_index()



    