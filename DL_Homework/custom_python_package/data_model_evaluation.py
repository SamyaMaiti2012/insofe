from sklearn.metrics import roc_curve, auc, accuracy_score,classification_report, recall_score,precision_score,precision_recall_curve,average_precision_score, silhouette_score,roc_curve, auc,confusion_matrix,mean_absolute_error,mean_squared_error,roc_auc_score,f1_score


def evaluate_model(model, X, y):
    y_pred = model.predict(X)
    print("Accuracy score :", accuracy_score(y,y_pred))
    print("classification_report :\n",classification_report(y,y_pred,digits=4))
    return y_pred