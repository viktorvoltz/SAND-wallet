

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",	 // Localhost (default: none)
      port: 7545,		 // Standard Ethereum port (default: none)
      network_id: "*",	 // Any network (default: none)
      },
  },
  contracts_build_directory: "./src/artifacts/",

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.11",    // Fetch exact version from solc-bin (default: truffle's version)
      optimizer: {
        enabled: false,
        runs: 200
        },
        evmVersion: "byzantium"
    }
  },

};
