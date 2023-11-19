from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

def calculate_similarity(file1_path, file2_path):
    # Read the content of the files
    with open(file1_path, 'r') as file:
        content1 = file.read()

    with open(file2_path, 'r') as file:
        content2 = file.read()

    print("Read the two files")
    # Create a CountVectorizer
    vectorizer = CountVectorizer()

    # Fit and transform the content of the files
    X = vectorizer.fit_transform([content1, content2])

    # Compute the cosine similarity
    similarity_matrix = cosine_similarity(X)

    # The similarity value is at similarity_matrix[0, 1]
    similarity = similarity_matrix[0, 1]

    return similarity

# Example usage
if __name__ == "__main__":
    file1_path = 'docs/prince.txt'
    file2_path = 'docs/prince1.txt'

    similarity = calculate_similarity(file1_path, file2_path)
    print(f"Cosine Similarity between the files: {similarity}")
