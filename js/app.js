// const one = document.querySelector("#one");
// const b = document.querySelector("#b");

// import { MetaMaskSDK } from "@metamask/sdk";

// const MMSDK = new MetaMaskSDK({
//     dappMetadata: {
//       name: "JavaScript example dapp",
//       url: window.location.href,
//     },
//     infuraAPIKey: process.env.INFURA_API_KEY,
//     // Other options.
//   });
  
//   // You can also access via window.ethereum.
//   const ethereum = MMSDK.getProvider();

//   console.log(one.innerHTML);
// // b.onclick = () =>{
// //   console.log("in on");
// // }


//  on = ()=>{
//   console.log("on");
// }


const connectButton = document.getElementById("connectButton");
const walletID = document.getElementById("walletID");
console.log(ethereum);
if (typeof window.ethereum !== "undefined") {+
    ethereum
      .request({ method: "eth_requestAccounts" })
      .then((accounts) => {
        console.log(accounts);
        const account = accounts[0];

        walletID.innerHTML = `Wallet connected: ${account}`;
      })


      .request({method: 'eth_getBalance', params: [account, "latest"]})
        .then(balance => {
            setUserBalance(ethers.utils.formatEther(balance));
        })
} else {
      window.open("https://metamask.io/download/", "_blank");
}