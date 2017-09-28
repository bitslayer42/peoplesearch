import React from 'react';
import './css/Card.css';
  
export default class Card extends React.Component { 

 constructor(props) { 
    super(props);
    this.state = {
      picClasses: ['pics','grow'],
    };      
    this.onClick = this.onClick.bind(this);
    this.animateMe = this.animateMe.bind(this);
  }
  
  onClick (event){ 
    event.preventDefault();
    const clickType = event.target.getAttribute('data-type');
    const clickValue = event.target.getAttribute('data-value');
    this.props.onClick(clickType,clickValue);
  }
  
  animateMe(){  //animate
    const self = this;
    const origpicClasses = this.state.picClasses;
    let newpicClasses = [ ...this.state.picClasses,'large'];
    this.setState({
      picClasses: newpicClasses
    });
    setTimeout(()=>{
      self.setState({
        picClasses: origpicClasses
      });
    },1300);
    
  }
  
  render() {
    const staff = this.props.staff;
    const imgName = {backgroundImage:`url('http://missionondemand.msj.org/empphotos/${staff.FileName}')`};
    return (
      <div className="card">
        <div className={this.state.picClasses.join(' ')} style={imgName} onClick={this.animateMe}>
          <div className="ovaltext">
            {staff.Name}<br/>
            <div className="jobt" style={{fontSize:"0.7em"}}>{staff.JobTitle}</div>
          </div>
        </div>
        <div style={{fontSize:"0.8em",lineHeight:"1.2em",padding:"10px",textAlign:"left"}}>
          <div style={{fontSize:"1.2em"}}><b>{staff.Name}</b></div>
          <div style={{color:"green",fontSize:"1.2em"}}>{staff.JobTitle}</div>
            {staff.SupervisorName 
              && <div><i>Supervisor: </i> 
                <a href="supervisor" onClick={this.onClick} data-type="supv" data-value={staff.SupervisorID}>{staff.SupervisorName}</a></div>}
            {staff.DepartmentName 
              && <div><i>Department: </i> 
                <a href="department" onClick={this.onClick} data-type="dept" data-value={staff.Department}>
                  {staff.Department}-{staff.DepartmentName}
                </a>
               </div>}
            {staff.JobTitle 
              && <div><i>Job Code: </i> 
                <a href="jobcode" onClick={this.onClick} data-type="job" data-value={staff.JobCode}>
                  {staff.JobCode}-{staff.JobTitle}
                </a>
               </div>}
            {staff.SupveeCount > 0 
              && <div>Supervises <a href="supervises" onClick={this.onClick} data-type="supv" data-value={staff.EmployeeID}>
                {staff.SupveeCount} staff</a>
               </div>}

        </div>
        <div style={{fontSize:"0.8em",lineHeight:"1.2em",padding:"10px",textAlign:"left"}}>
            {staff.Extension && <div><i>Extension:</i><b>{staff.Extension}</b></div>}
            {staff.OfficePhone && <div><i>Office Phone:</i> {staff.OfficePhone}</div>}
            {staff.Mobile && <div><i>Mobile:</i> {staff.Mobile}</div>}
            {staff.Pager && <div><i>Pager:</i> {staff.Pager}</div>}
            {staff.Email && <div><i>EMail:</i> <a href="mailto:{staff.Email}">{staff.Email}</a></div>}
            {staff.StreetAddress && <div><i>Business Address:</i> 
              <div><b>{staff.StreetAddress}<br />
              {staff.City},{staff.State} {staff.PostalCode}</b>
              </div>
              </div>
            }


        </div>
      </div>                
    )
  }
}