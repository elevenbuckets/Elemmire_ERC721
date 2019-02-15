'use strict';

// const fs   = require('fs');
// const path = require('path');
// const ethUtils = require('ethereumjs-utils');
// const mkdirp = require('mkdirp');
const biapi = require('bladeiron_api');

// 11BE BladeIron Client API
const BladeIronClient = require('bladeiron_api');

class Elemmire extends BladeIronClient {
	constructor(rpcport, rpchost, options)
        {
		super(rpcport, rpchost, options);
	}
}

module.exports = Elemmire;
