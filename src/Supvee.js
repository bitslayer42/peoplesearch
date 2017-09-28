import React from 'react';
import './css/Card.css';
  
export default class Supvee extends React.Component { 

 constructor(props) { 
    super(props);
    this.onClick = this.onClick.bind(this);
  }
  
  onClick (event){ 
    event.preventDefault();
    this.props.onClick("supv",this.props.supvee.EmployeeID);
  }
  
  render() {
    const supvee = this.props.supvee;
    const imgName = {backgroundImage:`url('http://missionondemand.msj.org/empphotos/${supvee.FileName}')`};
    return (
      <a href="supv" onClick={this.onClick}>
        <div className="pics" style={imgName}>
          <div className="ovaltext">
            {supvee.Name}<br/>
            <div className="jobt" style={{fontSize:"0.7em"}}>{supvee.JobTitle}</div>
          </div>
          {supvee.SupveeCount > 0 
          && <div className="supveecount">
             {supvee.SupveeCount}
						 </div>  
          }             
        </div>
      </a>
    )
  }
}