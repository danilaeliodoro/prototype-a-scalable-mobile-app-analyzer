pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Strings.sol";

contract LybePrototypeASCA {
    // Mapping to store app analysis results
    mapping (address => mapping (string => uint256[])) public appAnalysis;

    // Event emitted when a new app analysis is submitted
    event NewAnalysis(address indexed _submitter, string _appName, uint256[] _analysis);

    // Function to submit a new app analysis
    function submitAnalysis(string memory _appName, uint256[] memory _analysis) public {
        appAnalysis[msg.sender][_appName] = _analysis;
        emit NewAnalysis(msg.sender, _appName, _analysis);
    }

    // Function to get the analysis results for a specific app
    function getAppAnalysis(address _submitter, string memory _appName) public view returns (uint256[] memory) {
        return appAnalysis[_submitter][_appName];
    }

    // Function to get all analysis results for a submitter
    function getSubmitterAnalyses(address _submitter) public view returns (string[] memory, uint256[][] memory) {
        string[] memory appNames = new string[](0);
        uint256[][] memory analyses = new uint256[][](0);

        for (string memory appName in appAnalysis[_submitter]) {
            appNames.push(appName);
            analyses.push(appAnalysis[_submitter][appName]);
        }

        return (appNames, analyses);
    }
}