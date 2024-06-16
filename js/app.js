
// const connectWallet = document.createElement('button');
// connectWallet.textContent = "connect wallet";
const connectWallet = document.createElement('button');
const walletID = document.getElementById("walletID");
let account;
// walletID.innerHTML = `Wallet connected: ${account}`;
  connectWallet.onclick = () =>{

if (typeof window.ethereum !== "undefined")  {
  // connectWallet.onclick = () =>{
  ethereum
  .request({ method: "eth_requestAccounts" })
  .then((accounts) => {
    console.log(accounts);
    account = accounts[0];

    walletID.innerHTML = `Wallet connected: ${account}`;
  })
}
}

if(!account){
  connectWallet.textContent = "connect wallet";
  document.body.appendChild(connectWallet);
}
else{
  walletID.innerHTML = "V";
}

connectWallet.onclick = () =>{
  if (typeof window.ethereum !== "undefined")  {
    ethereum
    .request({ method: "eth_requestAccounts" })
    .then((accounts) => {
      console.log(accounts);
      account = accounts[0];
  
      walletID.innerHTML = `Wallet connected: ${account}`;
    })
  }
  else{
    window.open("https://metamask.io/download/", "_blank");
  }
  }

  
  