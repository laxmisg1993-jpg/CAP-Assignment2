namespace PRM;

using {managed, cuid} from '@sap/cds/common';


entity Partner : managed, cuid {
  FirstName : String(100);
  LastName  : String(100);
  contacts  : Composition of many Contacts on contacts.partner = $self;
}

entity Contacts : managed, cuid {
  FirstName : String(100);
  LastName  : String(100);
  Email     : String(100);
  partner   : Association to Partner;
}

entity Matches : managed, cuid {
  Partner1 : Association to Partner;
  Partner2 : Association to Partner;
  matchdate: Date;
  status   : String(10);
  manofthematch : Association to Contacts;
  winner   : Association to Partner;
  score    : Composition of many Scores on score.match = $self;
}

entity Scores : cuid {
  match  : Association to Matches;
  player : Association to Contacts;
  runsscored : Integer default 0;
}