import jwt from 'jsonwebtoken'
import bcryptjs from 'bcryptjs'
import HolyPlaceModel from '../Models/Holyplace.js';
import UserModel from '../Models/User.js';
import RepresentativeModel from '../Models/Representative.js';



export const createHolyPlace = async (httpreq, httpres) => {

    try {

      const getHolyPlaceInfo = httpreq.body;
      const holyplace = new HolyPlaceModel(getHolyPlaceInfo);
  
      const creator = await RepresentativeModel.findById({

        _id: getHolyPlaceInfo.createdby,
      });
      if(creator == null){
        return httpres
        .status(400)
        .json({ message: "Sorry Failed to Create holyplace." });
      }

      if(creator){
          if(typeof creator.holyplace == 'undefined' ){
            creator.holyplace = holyplace;
            await holyplace.save();

            await creator.save();
            return httpres.status(201).json({ message: "holyplace Created" });         
          }
          else {
            return httpres

              .status(400)

              .json({ message: "Sorry Failed to Create holyplace." });
          }
        
      } 

    } catch (error) {

      console.log(error);

    }


  };

// get all Holyplaces 


  export const getAllHolyPlaces = async (httpreq, httpres) => {
    try {
      const holyplaces = await HolyPlaceModel.find();

      if (holyplaces != null) {
          
          const lastholyplace = holyplaces.length - 1;
        
          await holyplaces.map(async (holyplace , index)=>{

          const creator = await RepresentativeModel.findById({

            _id: holyplace.createdby,

          });

          holyplace.createdby = creator;

          if(index == lastholyplace){

            console.log(holyplaces);

            return httpres.status(200).json({ holyplaces:  holyplaces });

          }

        });

      } else {
        return httpres.status(400).send("Sorry, didnt get any holyplaces!");
      }
  
    } catch (error) {
      console.log(error);
    }
  };


  

