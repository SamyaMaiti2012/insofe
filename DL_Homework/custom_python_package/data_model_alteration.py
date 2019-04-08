import pandas as pd
from sklearn.decomposition import PCA
import numpy as np
from sklearn.preprocessing import OneHotEncoder, LabelEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.impute import SimpleImputer
from imblearn.over_sampling import SMOTE
from sklearn.pipeline import Pipeline
from deprecated import deprecated
from imblearn.pipeline import Pipeline as impipe
from sklearn import svm
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier



def impute_num(dataF,impute_function):
    if (impute_function == "mean"):
        return dataF.apply(lambda col: col.fillna(col.mean()),axis=0)


def impute_cat(dataF,impute_function):
    if (impute_function == "mode"):
        return dataF.apply(lambda col:col.fillna(col.value_counts().index[0]))


def do_pca(dataF, n_components=None):
    pca_obj = PCA(n_components)
    pca_obj.fit(dataF)
    return pca_obj



def get_pca_transformation_stats(dataF):
    pca_obj = do_pca(dataF)
    dataF_df = pd.DataFrame(np.cumsum(pca_obj.explained_variance_ratio_)).reset_index()
    dataF_df['index'] = dataF_df['index']+1
    dataF_df = dataF_df.rename({"index": "Number of PC", 0: "Cumulative Sum of variance"}, axis=1)
    return dataF_df


def get_two_pca_trnsformed_data(dataF, n_components=2):
    pca_obj = do_pca(dataF, n_components)
    principalComponents = pca_obj.fit_transform(dataF)
    principalDf = pd.DataFrame(data = principalComponents, columns = ['pc1', 'pc2'])
    return principalDf
    


def define_num_transformer(**transformers):
    steps=[]
    for key, value in transformers.items():
        if(key == "imputer"):
            steps.append((key, SimpleImputer(strategy=value)))
        elif(key == "scaler"):
            steps.append((key, StandardScaler()))
        else:
            return "Not a valid transformation"    
    return Pipeline(memory ='./' ,steps=steps)


def define_cat_transformer(**transformers):
    steps=[]
    for key, value in transformers.items():
        if(key == "imputer"):
            steps.append(('imputer', SimpleImputer(strategy='most_frequent', fill_value='missing')))
        elif(key == "dummyfication_onehot"):
            steps.append(('onehot', OneHotEncoder(handle_unknown='ignore')))
        else:
            return "Not a valid transformation"
    return Pipeline(memory ='./' ,steps=steps)


def get_column_transformer(num_transformer=None, num_col_split=None, cat_transformer=None, cat_col_split=None):
    transformer_step=[]
    if(num_transformer != None):
        transformer_step.append(('num', num_transformer, num_col_split))
    if(cat_transformer != None):
        transformer_step.append(('cat', cat_transformer, cat_col_split))
    return ColumnTransformer(transformers=transformer_step)        


def simple_calssification_grid_space():
    return [{'classifier': [LogisticRegression()],
             'classifier__C': [3,7],
             'classifier__penalty': ["l1","l2"],
             'classifier__class_weight': [None, "balanced"]},
            {'classifier': [DecisionTreeClassifier(random_state=0)],
             'classifier__max_depth': [2,3,5,9],
             'classifier__class_weight': [None, "balanced"]},
            {'classifier': [svm.SVC()],
             'classifier__kernel': ['linear', 'rbf','poly'], 
             'classifier__C':[1.5, 10],
             'classifier__gamma': [1e-7, 1e-4],
             'classifier__class_weight': [None, "balanced"]}]


@deprecated
def complex_calssification_grid_space():
    return ""



def test_simple_calssification_grid_space():
    return [{'classifier': [LogisticRegression()],
             'classifier__C': [3,7],
             'classifier__penalty': ["l1","l2"]}]


@deprecated
def simple_regression_grid_space():
    return ""


@deprecated
def complex_regression_grid_space():
    return ""


@deprecated
def simple_clustering_grid_space():
    return ""


@deprecated
def complex_clustering_grid_space():
    return ""


def add_to_pipeline(**final_pipeline_steps):
    steps=[]
    for key, value in final_pipeline_steps.items():
        if(key == "preprocessor"):
            steps.append(('preprocessor', value))
        elif(key == "baseModel"):
            steps.append(('classifier', value))
        else:
            return "Not a valid step"
    return impipe(steps=steps)



def get_grid_summary(gs_model):
    print('Best score = ', gs_model.best_score_)
    print('\n')
    
    print('Best parameter : ')
    print(gs_model.best_params_)    
    print('\n')
    
    print('Best Model : ')
    print(gs_model.best_estimator_.get_params()['classifier'])
    print('\n')
    
    print('Grid search execution stat :')
    return pd.DataFrame(gs_model.cv_results_)

