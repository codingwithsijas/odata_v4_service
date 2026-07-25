const cds = require('@sap/cds');

module.exports = class TravelService extends cds.ApplicationService {

  async init() {
    const { Trips } = this.entities;

    this.on('cancelTrip', Trips, async (req) => {
      const [{ TripId }] = await SELECT.from(req.subject);
      const trip = await SELECT.one.from(Trips).where({ TripId });
      if (trip.Status === 'cancelled') return req.error(400, `Trip ${TripId} is already cancelled.`);
      await UPDATE(Trips).set({ Status: 'cancelled' }).where({ TripId });
      return SELECT.one.from(Trips).where({ TripId });
    });

    this.on('resumeTrip', Trips, async (req) => {
      const [{ TripId }] = await SELECT.from(req.subject);
      const trip = await SELECT.one.from(Trips).where({ TripId });
      if (trip.Status !== 'cancelled') return req.error(400, `Trip ${TripId} is not cancelled.`);
      await UPDATE(Trips).set({ Status: 'active' }).where({ TripId });
      return SELECT.one.from(Trips).where({ TripId });
    });

    return super.init();
  }
};
