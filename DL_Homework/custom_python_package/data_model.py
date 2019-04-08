from sklearn.linear_model import LogisticRegression
from scipy.stats import chi2_contingency
from scipy.stats import chi2
from sklearn.preprocessing import LabelEncoder
import pandas as pd



def logistic_regg_Corr(dataF, target, solver='liblinear'):
    """
    This is to understand correlation between continuous IV & Categorical DV.
    """
    dataF_corr = dataF.dropna()
    X=dataF_corr.drop(target, axis=1)
    y=dataF_corr[target]
    for col_cor in X.columns :
        X_col_cor = X[col_cor].values.reshape(-1, 1)
        clf = LogisticRegression(random_state=0, solver=solver).fit(X_col_cor, y)
        print("Mean accuracy with column", col_cor, "is :", clf.score(X_col_cor, y))
        
        
        
def get_chi_square_corr_score(dataF, target, prob=0.95):
    """
    The Pearson’s chi-squared statistical hypothesis is an example of a test for independence between categorical variables.
    """
    le = LabelEncoder()
    le.fit(dataF[target])
    dataF[target] = le.transform(dataF[target])
    
    alpha = 1.0 - prob
    print('Confidence level=%.3f and significance level=%.3f \n' % (prob, alpha))
    
    for column in dataF.columns:
        dataF[column].fillna(dataF[column].mode()[0], inplace=True)
        table = pd.crosstab(dataF[column], dataF[target])
        stat, p, dof, expected = chi2_contingency(table)
        
        """
        critical = chi2.ppf(prob, dof)
        print('probability=%.3f, critical=%.3f, stat=%.3f' % (prob, critical, stat))
        
        if abs(stat) >= critical:
            print('Dependent (reject H0), IV & DV are dependent')
        else:
            print('Independent (fail to reject H0), IV & DV are independent')
        """
        
        if p <= alpha:
            #print('Dependent (reject H0), IV & DV are dependent')
            print('IV : %s and DV: %s are dependent' % (column, target))
        else:
            #print('Independent (fail to reject H0), IV & DV are independent')
            print('IV : %s and DV: %s are independent' % (column, target))


            
    
    
    
    
    
    
