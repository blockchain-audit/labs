
const connectWallet = document.createElement('button');
connectWallet.textContent = "connect wallet";
const walletID = document.getElementById("walletID");
document.body.appendChild(connectWallet);

connectWallet.onclick = () =>{
  if (typeof window.ethereum !== "undefined")  {
    ethereum
    .request({ method: "eth_requestAccounts" })
    .then((accounts) => {
      console.log(accounts);
      const account = accounts[0];

      walletID.innerHTML = `Wallet connected: ${account}`;
    })
    document.body.removeChild(connectWallet);
  }
  else{
    window.open("https://metamask.io/download/", "_blank");
  }
}


