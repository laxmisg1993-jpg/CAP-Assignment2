using PRM from '../db/schema';

@protocol: ['odata-v4']
service PRMService @(path: '/PRM')
{
    entity Partners as projection on PRM.Partner; 
    entity Contacts as projection on PRM.Contacts;
    entity Matches as projection on PRM.Matches;
    entity Scores as projection on PRM.Scores;

    action finishMatch(matchId: UUID) returns String;
    function getMatchSummary(matchId: UUID) returns String;
}
