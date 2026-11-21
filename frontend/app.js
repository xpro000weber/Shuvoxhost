// UI starter only. Connect this to authenticated API endpoints before production.
fetch('/api/health').then(r=>r.json()).then(data=>console.log('ShuvoX API:',data)).catch(()=>{});
￼Enter
