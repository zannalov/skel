#!/usr/bin/env node

var input = '';
process.stdin.setEncoding( 'utf8' );
process.stdin.on( 'data' , function( chunk ) {
    input += chunk;
    delete chunk;
    processCompletedLines();
} );
process.stdin.on( 'end' , function() {
    processAllLines();
} );

var lines = null;
var filenameToHash = {};
function processCompletedLines() {
    input = input.split( '\n' );
    lines = input.slice( 0 , -1 );
    input = input[ input.length - 1 ];
    processWholeLines();
}
function processAllLines() {
    lines = input.split( '\n' );
    processWholeLines();
    sortOutput();
}
function processWholeLines() {
    lines.forEach( function( line ) {
        if( !line ) {
            delete line;
            return;
        }

        var match = line.match( /^([^ ]*)  (.*)$/ );
        if( !match ) {
            console.error( 'Invalid input line:' , line );
            delete line;
            return;
        }

        filenameToHash[ match[ 2 ] ] = match[ 1 ];

        delete match;
        delete line;
    } );

    delete lines;
}
function sortOutput() {
    Object.keys( filenameToHash ).forEach( function( filename ) {
        console.log( filenameToHash[ filename ] + '  ' + filename );
        delete filename;
    } );
}
