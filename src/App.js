import React, { Component } from 'react';
import SearchBox from './SearchBox';
import Result from './Result';
import './css/App.css';
//import logo from './images/logo.png';<img src={logo} alt="logo" style={{marginTop:"40px"}}/>

class App extends Component {
 constructor(props) { 
    super(props);
    this.state = {
      searchObj: {}, //has either SearchTerm, or 1 staff record
    };

    this.handleSel = this.handleSel.bind(this);
  }
  
  handleSel=(searchObj)=>{ //debugger;
    this.setState({
      searchObj
    }, ()=>{
      if(searchObj.SearchTerm) {
        console.log("SearchTerm: ",searchObj.SearchTerm,searchObj);
      }else{
        console.log("display: ",searchObj);
      }
    }); 
  } 
  
  render() {
    return (
      <div className="App">
        <span className="return">
          <a href="/">Return to home page.</a>
        </span>
        <div className="header">
          
          <div className="title">People Search</div>
          <SearchBox handleSel={this.handleSel}/>
        </div>
        
        <Result searchObj={this.state.searchObj} />
      

      </div>
    );
  }
}

export default App;
