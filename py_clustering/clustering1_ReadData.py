import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import glob
import os
from sklearn.cluster import KMeans
from sklearn.cluster import DBSCAN
from scipy.spatial.distance import pdist, squareform
import numpy.polynomial.polynomial as poly

ord = 3
cutRat = 1/4
minpts = 25
structName = 'bladder'

# load csv
fn = 'Objectives_relative_1_100.csv'
ffn = os.path.join(os.getcwd(), fn)
T = pd.read_csv(ffn)

# straight messy column names
T.columns = T.columns.str.strip().str.lower().str.replace(' ', '_')
T.structure_id = T.structure_id.str.lower().str.replace('_', '')
T.metric = T.metric.str.lower()

## bladder uppder point
# data
M = T[(T.structure_id == structName) & (T.metric == 'upper point objective relative')]
X = M[['value', 'property']].values
np.save('data.npy', X)

# patient
pt = M.patient_id.values
uniq_pt, counts_pt = np.unique(pt, return_counts=True)
avg_pt = np.round(np.mean(counts_pt))

# dbscan
dists = squareform(pdist(X, 'euclidean'))
sd = np.sort(dists, axis = 0)
yy = np.sort(sd[minpts-1, :])
xx = np.arange(len(yy))
m = round(len(yy)*cutRat)

xx = xx[m:]
yy = yy[m:]

fig = plt.figure(figsize=(16, 4))

plt.subplot(141)
plt.plot(xx, yy, 'bo')
# plt.hold(True)
s = []
for n in range(2, minpts):
    y1 = yy[-n:]
    x1 = xx[-n:]
    p1 = poly.polyfit(x1, y1, 1)
    y1v = poly.polyval(x1, p1)
    y2 = yy[:-n]
    x2 = xx[:-n]
    p2 = poly.polyfit(x2, y2, ord)
    y2v = poly.polyval(x2, p2)
    junk1 = np.subtract(y1v, y1)
    junk1 = np.power(junk1, 2)
    junk1 = np.sum(junk1)
    junk2 = np.subtract(y2v, y2)
    junk2 = np.power(junk2, 2)
    junk2 = np.sum(junk2)
    s.append(junk1+junk2)

ss = np.array(s)
idx = np.argmin(ss)
y1 = yy[-idx-2:]
x1 = xx[-idx-2:]
p1 = poly.polyfit(x1, y1, 1)
y1v = poly.polyval(x1, p1)
y2 = yy[:-idx-2]
x2 = xx[:-idx-2]
p2 = poly.polyfit(x2, y2, ord)
y2v = poly.polyval(x2, p2)

plt.plot(x1, y1v, 'g')
plt.plot(x2, y2v, 'c')
plt.plot(x1[0], y1[0], 'rd', markersize=12)

plt.xlabel('pdist points')
plt.ylabel('pdist')
plt.title('Knee point')

plt.grid(True)
plt.tight_layout()

plt.subplot(142)
plt.plot(ss, 'b-o')
plt.title('Finding knee point')

# knee point
if p1[1]<1:
    epsilon = max(yy)
else:
    epsilon = y1[0]


# kmeans
# y_pred = KMeans(n_clusters=4).fit_predict(X)
# plt.scatter(X[:, 0], X[:, 1], c=y_pred)
# plt.show()

# dbscan
db = DBSCAN(eps = epsilon, min_samples=minpts).fit(X)
core_samples_mask = np.zeros_like(db.labels_, dtype=bool)
core_samples_mask[db.core_sample_indices_] = True
labels = db.labels_
unique_labels = set(labels)
colors = [plt.cm.Spectral(each) for each in np.linspace(0.8, 0.2, len(unique_labels))]
plt.subplot(143)
plt.title('Outliers')

for k, col in zip(unique_labels, colors):
    if k == -1:
        # Black used for noise.
        col = [1, 0, 0, 1]

    class_member_mask = (labels == k)

    xy = X[class_member_mask & core_samples_mask]
    plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
             markeredgecolor='k', markersize=14)

    xy = X[class_member_mask & ~core_samples_mask]
    plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
             markeredgecolor='k', markersize=6)

# remove outlier
X = X[labels!=-1,:]

# kmeans
y_pred = KMeans(n_clusters=int(avg_pt)).fit_predict(X)
plt.subplot(144)
plt.scatter(X[:, 0], X[:, 1], c=y_pred, edgecolor='k', s=128)
plt.title('KMeans')

# plt.scatter(X[:, 0], X[:, 1], c=db.labels_)
plt.show()
