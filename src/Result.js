import React from 'react';
//import axios from 'axios'; //ajax library
//import { LibPath } from './LibPath';
import Card from './Card';
import Supvee from './Supvee';
import './css/Result.css';
import StaffData from './StaffData';

export default class Result extends React.Component { 

  constructor(props) {
    super(props);

    this.state = {
      selected: {"staff":[],"supvees":[]}      //selected people object 
    };  
    this.onClick = this.onClick.bind(this);
  }

  componentWillReceiveProps(nextProps) { 
    if(this.props !== nextProps){
      let paramObj = {
        maxrows: 0,  //zero for unlimited       
      };
      if(nextProps.searchObj.SearchTerm) {
        paramObj.searchby = nextProps.searchObj.SearchTerm;
      }else{
        paramObj.id = nextProps.searchObj.EmployeeID;
      }
      this.fetchData(paramObj);
    }
  }
  
  fetchData(params){ 
    let SelStaff = {};
    SelStaff.staff = StaffData.filter(aStaff=>{
      return aStaff.Name.includes(params);
    })
    this.setState({
      selected: SelStaff
    });
  }
  
  onClick(clickType,clickValue) {  //user clicked on clickType: supv, dept, or job
    const paramObj = { [clickType]:clickValue }; //ES6 ComputerPropertyName
    this.fetchData(paramObj);
  }
  
  render()  { 
    return (
      <div className="results">
        {
          this.state.selected.staff.map((staff,ix) => {
            return (
              <div key={ix} style={{width:"800px",margin:"0 auto"}}>
                <div><Card staff={staff} onClick={this.onClick} /></div>
              </div>
            )
          })
        }
        {this.state.selected.supvees
        && this.state.selected.supvees.length > 0 
        && <div style={{fontWeight:"bold",textAlign:"left",width:"800px",margin:"0 auto"}}>{this.state.selected.staff[0].FirstName} {this.state.selected.staff[0].LastName} supervises&nbsp; 
              {this.state.selected.staff[0].SupveeCount} staff: </div>
        }
        <div className="supveebox">
          { this.state.selected.supvees &&
            this.state.selected.supvees.map((supvee,ix) => {
              return (
                <Supvee key={ix} supvee={supvee} onClick={this.onClick} />
              )
            })        
          }
        </div>
      </div>
    )
  }
};
