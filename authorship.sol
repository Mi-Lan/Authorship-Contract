pragma solidity ^0.5.11;

contract Author{
    
    struct Creator{
        
        bool avaliability;
        uint price;
        address owner;
    }
    
    mapping(bytes32=>Creator) songToStruct;
    
    address administrator;
    
    constructor () public{
        administrator=msg.sender;
    }
    
    
    function claimAuthorship(string memory songName,bool forSelling, uint price) public returns (string memory){
        bytes32 song= keccak256(abi.encodePacked(songName));
        require ((songToStruct[song].owner==0x0000000000000000000000000000000000000000&&price!=0),"Song already has an author or Invalid price!");
        
        songToStruct[song]=Creator(forSelling,price,msg.sender);
        
        return "succesfull";
        
    }
    
    function getPrice(string memory song)public view returns( uint){
        bytes32 songer= keccak256(abi.encodePacked(song));
        require(songToStruct[songer].price!=0,"Invalid song name");
      
          return songToStruct[songer].price;
     
    }
    
    function setAvaliablity(string memory song,bool avaliabilitye) public{
        bytes32 songer= keccak256(abi.encodePacked(song));
        
        require(songToStruct[songer].owner==msg.sender,"You are not an author");
        
        songToStruct[songer].avaliability=avaliabilitye;
    }
    
   
    
     function buyRights(string memory songer) public payable{
         bytes32 song= keccak256(abi.encodePacked(songer));
         
         if(msg.value>=songToStruct[song].price&&songToStruct[song].avaliability){
            songToStruct[song].owner=msg.sender;
          
            address simpleAddress=songToStruct[song].owner;
            address payable addressPayable = address(uint160(simpleAddress));
            addressPayable.transfer(msg.value ); 
             
         }else{
             revert();
         }
        
    }
    
}
