pragma solidity ^0.5.11;

contract Author{
    
    struct Creator{
        string song; 
        bool avaliability;
        uint price;
    }
    
    mapping(address=>Creator) authors;
    mapping(string=>address) songToAddress;
    
    address administrator;
    
    
    constructor () public{
        administrator=msg.sender;
    }
    
    
    function claimAuthorship(string memory songName,bool forSelling, uint price) public returns (string memory){
        
        require ((songToAddress[songName]==0x0000000000000000000000000000000000000000&&price!=0),"Song already has an author or Invalid price!");
      
         authors[msg.sender]=Creator(songName,forSelling,price);
         songToAddress[songName]=msg.sender;
        
        
        
         return "succesfull";
        
    }
    
    function getPrice(string memory song)public view returns( uint){
        require(authors[songToAddress[song]].price!=0,"Invalid song name");
      
          return authors[songToAddress[song]].price;
      
        
        
        
    }
    
    function setAvaliablity(string memory song,bool avaliabilitye) public{
        
        require(songToAddress[song]==msg.sender,"You are not an author");
        
        authors[msg.sender].avaliability=avaliabilitye;
    }
        
        
    

    
     function buyRights(string memory songer) public payable{
         
         if(msg.value>=authors[songToAddress[songer]].price&&authors[songToAddress[songer]].avaliability){
             songToAddress[songer]=msg.sender;
             authors[songToAddress[songer]].song="nista";
         }else{
             revert();
         }
        
    }
    
}