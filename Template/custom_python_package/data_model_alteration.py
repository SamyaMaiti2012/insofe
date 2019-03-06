import pandas as pd
from sklearn.decomposition import PCA
import numpy as np
from sklearn.preprocessing import OneHotEncoder, LabelEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.impute import SimpleImputer
from imblearn.over_sampling import SMOTE
from sklearn.pipeline import Pipeline
from deprecated import deprecated



def impute_num(dataF,impute_function):
    if (impute_function == "mean"):
        return dataF.apply(lambda col: col.fillna(col.mean()),axis=0)


def impute_cat(dataF,impute_function):
    if (impute_function == "mode"):
        return dataF.apply(lambda col:col.fillna(col.value_counts().index[0]))

    
def do_pca_transformation(dataF):
    X=dataF.drop('Severity', axis=1)
    y=dataF["Severity"]

    pca = PCA()
    pca.fit(X)

    dataF_df = pd.DataFrame(np.cumsum(pca.explained_variance_ratio_)).reset_index()
    dataF_df['index'] = dataF_df['index']+1
    dataF_df = dataF_df.rename({"index": "Number of PC", 0: "Cumulative Sum of variance"}, axis=1)
    return dataF_df

#@deprecated
def define_num_transformer(**transformers):
    steps=[]
    for key, value in transformers.items():
        if(key == "imputer"):
            steps.append((key, SimpleImputer(strategy=value)))
        elif(key == "scaler"):
            steps.append((key, StandardScaler()))
        else:
            return "Not a valid transformation"
        print(steps)
        pipeline = Pipeline(memory ='./' ,steps=[steps])
        print(pipeline)
    return pipeline

#@deprecated
def define_cat_transformer(**transformers):
    steps=[]
    for key, value in transformers.items():
        if(key == "imputer"):
            steps.append(('imputer', SimpleImputer(strategy='most_frequent', fill_value='missing')))
        elif(key == "dummyfication_onehot"):
            steps.append(('onehot', OneHotEncoder(handle_unknown='ignore')))
        else:
            return "Not a valid transformation"
    return Pipeline(memory ='./' ,steps=[steps])

#@deprecated
def get_column_transformer(num_transformer=None, num_col_split=None, cat_transformer=None, cat_col_split=None):
    transformer_step=[]
    if(num_transformer != None):
        transformer_step.append(('num', num_transformer, num_col_split))
    if(cat_transformer != None):
        transformer_step.append(('cat', cat_transformer, cat_col_split))
    return ColumnTransformer(transformer_step)        
    