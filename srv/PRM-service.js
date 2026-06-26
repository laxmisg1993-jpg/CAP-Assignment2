const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

  const { Matches, Scores, Contacts } = this.entities;

  // ✅ finishMatch (already done)
  this.on('finishMatch', async (req) => {
    const { matchId } = req.data;

    await UPDATE(Matches)
      .set({ status: 'OVER' })
      .where({ ID: matchId });

    return `Match ${matchId} has been marked as OVER`;
  });

  // ✅ ✅ ADD THIS FUNCTION HANDLER
  this.on('getMatchSummary', async (req) => {
    const { matchId } = req.data;

    // 1. Get match details
    const match = await SELECT.one.from(Matches).where({ ID: matchId });

    if (!match) {
      return req.error(404, 'Match not found');
    }

    // 2. Get scores of players in this match
    const scores = await SELECT.from(Scores)
      .where({ match_ID: matchId });

    // 3. Build summary
    let totalRuns = 0;
    let summary = `Match ID: ${matchId}\nStatus: ${match.status}\n`;

    for (let s of scores) {
      totalRuns += s.runsscored;
    }

    summary += `Total Runs: ${totalRuns}`;

    return summary;
  });

});
``