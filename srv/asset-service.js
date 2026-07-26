const cds = require('@sap/cds');

module.exports = class AssetService extends cds.ApplicationService {

  async init() {
    const { Assets } = this.entities;

    this.on('assignAsset', Assets, async (req) => {
      const { employeeID, locationID } = req.data;
      const [asset] = await SELECT.from(req.subject);
      if (asset.Status === 'Retired') return req.error(400, 'Cannot assign a retired asset.');
      if (asset.Status === 'Lost')    return req.error(400, 'Cannot assign a lost asset.');
      await UPDATE(Assets).set({
        Status: 'Assigned',
        assignedTo_ID: employeeID,
        location_ID: locationID ?? asset.location_ID
      }).where({ ID: asset.ID });
      await INSERT.into('itam.AssignmentHistory').entries({
        ID: cds.utils.uuid(),
        asset_ID: asset.ID,
        employee_ID: employeeID,
        AssignedDate: new Date().toISOString().slice(0, 10)
      });
      return SELECT.one.from(Assets).where({ ID: asset.ID });
    });

    this.on('returnAsset', Assets, async (req) => {
      const [asset] = await SELECT.from(req.subject);
      if (asset.Status !== 'Assigned') return req.error(400, 'Asset is not currently assigned.');
      await UPDATE(Assets).set({ Status: 'Available', assignedTo_ID: null }).where({ ID: asset.ID });
      await UPDATE('itam.AssignmentHistory')
        .set({ ReturnedDate: new Date().toISOString().slice(0, 10) })
        .where({ asset_ID: asset.ID, ReturnedDate: null });
      return SELECT.one.from(Assets).where({ ID: asset.ID });
    });

    this.on('sendForMaintenance', Assets, async (req) => {
      const { vendorID } = req.data;
      const [asset] = await SELECT.from(req.subject);
      if (asset.Status === 'Retired') return req.error(400, 'Cannot send a retired asset for maintenance.');
      await UPDATE(Assets).set({ Status: 'Maintenance' }).where({ ID: asset.ID });
      await INSERT.into('itam.MaintenanceRecord').entries({
        ID: cds.utils.uuid(),
        asset_ID: asset.ID,
        vendor_ID: vendorID,
        MaintenanceDate: new Date().toISOString().slice(0, 10),
        Type: 'Corrective'
      });
      return SELECT.one.from(Assets).where({ ID: asset.ID });
    });

    this.on('completeMaintenance', Assets, async (req) => {
      const [asset] = await SELECT.from(req.subject);
      if (asset.Status !== 'Maintenance') return req.error(400, 'Asset is not under maintenance.');
      await UPDATE(Assets).set({ Status: 'Available' }).where({ ID: asset.ID });
      return SELECT.one.from(Assets).where({ ID: asset.ID });
    });

    this.on('markAsLost', Assets, async (req) => {
      const [asset] = await SELECT.from(req.subject);
      if (['Retired', 'Lost'].includes(asset.Status))
        return req.error(400, `Asset is already ${asset.Status.toLowerCase()}.`);
      await UPDATE(Assets).set({ Status: 'Lost', assignedTo_ID: null }).where({ ID: asset.ID });
      return SELECT.one.from(Assets).where({ ID: asset.ID });
    });

    this.on('retireAsset', Assets, async (req) => {
      const [asset] = await SELECT.from(req.subject);
      if (asset.Status === 'Assigned')
        return req.error(400, 'Return the asset before retiring it.');
      await UPDATE(Assets).set({ Status: 'Retired', assignedTo_ID: null }).where({ ID: asset.ID });
      return SELECT.one.from(Assets).where({ ID: asset.ID });
    });

    return super.init();
  }
};
