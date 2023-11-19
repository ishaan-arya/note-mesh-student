# Importing Relevant Modules
import os
from sklearn.feature_extraction.text import TfidfVectorizer, ENGLISH_STOP_WORDS
from sklearn.cluster import KMeans
from statistics import mode

custom_stopwords = ["custom", "stop", "words", "to", "add", "new", "chapter", "like"]
def relevant_clustering(directory_path):
    res = {}
    documents = []
    filenames= []

    for filename in os.listdir(directory_path):
        if filename.endswith(".txt"):  
            file_path = os.path.join(directory_path, filename)
            
            # Open the file and read its content
            with open(file_path, 'r', encoding='utf-8') as file:
                file_content = file.read()
                documents.append(file_content)
                filenames.append(filename)
    all_stopwords = set(list(ENGLISH_STOP_WORDS) + custom_stopwords)

    vectorizer = TfidfVectorizer(stop_words=list(all_stopwords), max_features=5000)
    X = vectorizer.fit_transform(documents)

    # Apply K-means clustering
    optimal_clusters = 2
    kmeans = KMeans(n_clusters=optimal_clusters, random_state=42)
    kmeans.fit(X)

    cluster_assignments = kmeans.labels_

    terms = vectorizer.get_feature_names_out()
    cluster_keywords = []

    for i in range(optimal_clusters):
        cluster_indices = [index for index, label in enumerate(cluster_assignments) if label == i]
        cluster_X = X[cluster_indices]
        cluster_tfidf_sum = cluster_X.sum(axis=0)
        cluster_tfidf_scores = [(term, cluster_tfidf_sum[0, idx]) for idx, term in enumerate(terms)]
        sorted_keywords = sorted(cluster_tfidf_scores, key=lambda x: x[1], reverse=True)
        cluster_keywords.append({"Cluster": i, "Keywords": sorted_keywords})
    
    most_common_clusterid = mode(cluster_assignments)
    # Testing: printing when the script is called in command line
    if __name__ == "__main__":
        # Display keywords for each cluster (testing)
        for cluster_info in cluster_keywords:
            print(f"\nCluster {cluster_info['Cluster']} Keywords:")
            for keyword, tfidf_score in cluster_info['Keywords'][:10]:  # Display top 10 keywords per cluster
                print(f"{keyword}: {tfidf_score}")


        # Get the cluster with the most files under it (testing)
        print(f"\nCluster {most_common_clusterid + 1} appeared the most:")
        most_common_filenames = [filenames[i] for i in range(len(documents)) if cluster_assignments[i] == most_common_clusterid]
        print(" ".join(most_common_filenames))
    
    for keyword, tfidf_score in cluster_keywords[most_common_clusterid]['Keywords'][:20]:
        res[keyword] = tfidf_score
    return res
    
if __name__ == "__main__":
    print(relevant_clustering('./docs'))
