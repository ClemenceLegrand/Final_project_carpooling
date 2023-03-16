import streamlit as st
import pandas as pd
import numpy as np
import datetime
import pickle

data=pd.read_csv("/Users/clemence/IRONHACK/Final_project_carpool/Final_project_carpooling/data_model.csv")
data2=pd.read_csv("/Users/clemence/IRONHACK/Final_project_carpool/Final_project_carpooling/data_2nd_model.csv")

## Input des users
st.subheader("Predict the carpooling journeys around you and where they will drive you")
timeOfTheDay= st.time_input("Choose a time", datetime.time(8, 45,00))
st.write('Time:', timeOfTheDay)
st.markdown("Indicate your GPS location")
latitude= st.number_input("Indicate the latitude ", min_value=data['journey_start_lat'].min(),max_value=data['journey_start_lat'].max())
longitude= st.number_input("Indicate the longitude ", min_value=data['journey_start_lon'].min(),max_value=data['journey_start_lon'].max())
st.write('Your GPS location (latitude,longitude) : ', (latitude,longitude))

## Functions to load the models
def load_models():
    model = {}
    nb_pickupsModel=''
    with open('/Users/clemence/IRONHACK/Final_project_carpool/Final_project_carpooling/kmeansIDF.pickle', 'rb') as file:
        model['kmeansIDF_model'] = pickle.load(file)
 
    with open('/Users/clemence/IRONHACK/Final_project_carpool/Final_project_carpooling/knn2Model.pickle', 'rb') as file:
        model['knn2_model'] = pickle.load(file)

    with open('/Users/clemence/IRONHACK/Final_project_carpool/Final_project_carpooling/DTModel.pickle', 'rb') as file:
        model['DT_model'] = pickle.load(file)
    return model
def secondTime(t):
    seconds = (t.hour * 60 + t.minute) * 60 + t.second
    return seconds
model = load_models()

gps = {'lat': [latitude], 'lon': [longitude]}
clusterNo= int(model['kmeansIDF_model'].predict(pd.DataFrame(data=gps)))
hourInSec = secondTime(timeOfTheDay)
 
time_cluster = {'time': [hourInSec], 'cluster': [clusterNo]}
nb_journeys = model['knn2_model'].predict(pd.DataFrame(data=time_cluster))
destination=model['DT_model'].predict(pd.DataFrame(data=time_cluster))
 
st.write('At this hour, in this area, this is the count of proposed carpool trips :', int(nb_journeys), "and the towngroup destination will most likely be", str(destination))


