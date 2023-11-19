## GitHub Link to Note Mesh Professor Platform
https://github.com/ishaan-arya/note-mesh-professor

## Inspiration
Notemesh, driven by a vision for innovation, utilizes computer vision to distill handwritten notes into supernotes for students. It allows professors to provide insights into the most common topics, similarity scores, and prevalent words in students' notes. Note Mesh aspires to redefine the educational experience, bridging the gap between learners and educators through advanced technology and data-driven analytics.

## What it is
Note Mesh is a comprehensive platform consisting of a mobile app and a web app. Students use the mobile app to upload their notes after a lecture (which could be in any format). These notes are processed through a llama 2 LLM which extracts the recurring themes across the notes, and prepares a comprehensive "supernote". This document can be invaluable to students for revision and also for students facing learning disabilities. Additionally, the professor of the class has a web application where new lectures can be created in addition to an interactive dashboard featuring plots and data that represent the topics from lecture that resonated most with students and how students reacted to the material presented. We believe this data could help professors gain important feedback and alter their teaching methods to better cater to students.

## How we built it
Our app consists of a mobile app and a web app. For the frontend, we used Flutter and Dart. The backend is consisted of Python Flask that runs a server on local host. We used python flask CORS to allow cross-origin requests so that apps on phones/simulators can send HTTP requests to the server. Behind the server, we have an entire machine learning module that is powered by Meta’s llama2 large language model, python’s skilearn model (and pytorch) for cosine similarity score and k-means clustering, and fPDF for converting txt files to pdf files. 

## Challenges we ran into


In our project, the backend, powered by Python Flask, and the frontend, developed with Flutter and Dart, posed unique challenges. With the team splitting into two groups for each component, decisions regarding local server hosting versus Google Cloud and overcoming Flask CORS issues marked pivotal moments. Navigating llama2, scikit-learn, and fPDF, we meticulously crafted a functional backend.

On the frontend, Dart bugs and deployment hurdles tested our adaptability, compounded by the need for interfaces tailored to students and professors. Despite a 24-hour time crunch, both interfaces were completed. Connecting frontend and backend components introduced complexities, but our collaborative effort prevailed, resulting in a cohesive project that underscores our team's resilience.


## Accomplishments that we're proud of
We have come a long way in this project. At the start of the project, we decided to challenge ourselves by using ML models that were not in familiar territories and tried dart and flutter, amazing applications for web apps and mobile apps, for the front-end. Throughout this process, we gained valuable experiences in these frameworks and we would say this had to be one of the most productive nights we have had. 

## What we learned
Our mobile and web app, blending Flutter and Dart for the frontend and Python Flask for the local server backend, encountered unique challenges. Python Flask CORS facilitated cross-origin requests for mobile interactions. The backend, featuring llama2, scikit-learn (with PyTorch), and fPDF for text-to-PDF conversion, demanded meticulous attention.

Deciding between local server hosting and Google Cloud and overcoming Flask CORS hurdles marked crucial backend decisions. On the frontend, grappling with Dart bugs, deployment intricacies, and a tight 24-hour deadline for student and professor interfaces tested our adaptability. Connecting frontend and backend components introduced unexpected complexities.

Reflecting on our journey, we take pride in embracing unfamiliar ML models and exploring Dart and Flutter. This experience not only expanded our skills but also proved one of our most rewarding endeavors. Notably, the seemingly straightforward task of transforming text to PDF revealed unexpected difficulties, reinforcing the challenges inherent in innovative projects.

# Next for Note Mesh

Our vision extends beyond development; we aim to elevate Note Mesh to a production-level deployment, crafting a fully scalable solution. We hold a steadfast belief that Notemesh is poised to revolutionize learning for university students, providing a powerful tool for effective and enhanced education. Our commitment to scalability reflects our dedication to making a meaningful impact in the educational landscape, ensuring that Note Mesh becomes a valuable resource for countless students on their learning journeys.


### Machine Learning
- Uses Meta's llama for summarizing for super notes.
- Uses Skilearn for k-means clustering of relevant student notes
- Uses Skilearn to measure similarity between two text files
- Uses fitz to convert PDF to convert pdfs to txt.

To install dependencies, do
```pip install -r machine_learning/requirements.txt``` from the project root directory.

