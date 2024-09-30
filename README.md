 # Cyclus - Female Health & Wellbeing App  
 
Cyclus is a female health and wellness app built with Flutter, Dart, Firebase. Cyclus offers next menstrual cycle prediction, Guided fitness and yoga stretches. It utilizes a supervised trained ML Model for predictive analysis of the next menstrual cycle.


<img src="./app_model_shots/banner-cyclus.png" alt="" width="700">

## Screenshots
 
<table border>
     <tr>
        <th style="text-align:center" colspan="3">Onboarding Screens</th>
    </tr>
    <tr>
        <td><img src="./app_model_shots/onboarding1.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/onboarding2.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/onboarding3.png" alt="" width="220"></td>   
    <tr>
</table>

<table border>
     <tr>
        <th style="text-align:center" colspan="3">Registration & Login Screens</th>
    </tr>
    <tr>
        <td><img src="./app_model_shots/signup1.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/signup3.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/signin1.png" alt="" width="220"></td>
    <tr>
</table>

<table border>
     <tr>
        <th style="text-align:center" colspan="3">User Details for Registration</th>
    </tr>
    <tr>
        <td><img src="./app_model_shots/detail3.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/detail4.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/detail5.png" alt="" width="220"></td>
    <tr>
</table>

<table border>
     <tr>
        <th style="text-align:center" colspan="3">App Main Screen (Prediction) & Profile </th>
    </tr>
    <tr>
        <td><img src="./app_model_shots/main1.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/main2.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/main3.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/main4.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/profile1.png" alt="" width="220"></td>
    <tr>
</table>

<table border>
     <tr>
        <th style="text-align:center" colspan="3">Yoga Screens</th>
    </tr>
    <tr>
        <td><img src="./app_model_shots/yoga1.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/yoga2.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/yoga3.png" alt="" width="220"></td>
        <td><img src="./app_model_shots/yoga4.png" alt="" width="220"></td>
    <tr>
</table>

## **Machine Learning Model Details**

The predictive analysis for the menstrual cycle in Cyclus uses Regression Algorithms as the output variable is numeric.

### **Algorithms Used**
We implemented two machine learning algorithms to train our predictive model:

- **Linear Regression**:
  - Achieved a model accuracy of **97.04%**.
  - Linear Regression provided a foundational understanding of the relationship between cycle length and influencing factors.

- **Random Forest Regression**:
  - Achieved a model accuracy of **97.63%** after hyperparameter tuning.
  - This model was selected as the final solution due to its superior performance in handling complex patterns and non-linear relationships.

### **Hyperparameter Tuning**
- **RandomizedSearchCV** was utilized to perform hyperparameter tuning for the Random Forest model.
- This approach allowed for efficient searching across a wide range of parameters to identify the optimal settings, resulting in enhanced model performance and accuracy.

### **Model Deployment**
- The final model was saved using the **Joblib** library in .pkl format.
- The backend is integrated using a **Flask API** that communicates with the Flutter app, providing seamless data exchange for prediction results.

The predictive model integrates seamlessly with the app's backend, enabling accurate and timely menstrual cycle predictions for users. This combination of machine learning techniques ensures that Cyclus remains a reliable tool for female health and well-being.


