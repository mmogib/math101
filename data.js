function showGrades() {
  return {
    isLoading: false,
    fullname: null,
    key: null,
    kfupm_id: null,
    section: null,
    fields: null,
    airtable_base: "appLKzXucWNq7Ns0j",
    airtable_grades_table: "Grades",
    airtable_fields_table: "GradesFields",
    airtable_url: "https://api.airtable.com/v0",
    authorization: {
      headers: {
        Authorization:
          "Bearer patS1tloTkU4PXgRN.5abcc400a57b06eb826e629ca497ec3055af4c437da7d6ff91902e060a4bb4f5",
      },
    },
    scores: [],
    async init() {
      const urlParams = new URLSearchParams(window.location.search);
      const myParam = urlParams.get("key");
      this.key = myParam;
      this.fields = await this.getActiveFields();
      this.getScores();
    },
    getUrl(table) {
      return `${this.airtable_url}/${this.airtable_base}/${table}`;
    },
    async getActiveFields() {
      const url = new URL(this.getUrl(this.airtable_fields_table));
      url.searchParams.set("fields", "Label");
      url.searchParams.append("fields", "Field");
      url.searchParams.append(
        "filterByFormula",
        `AND(Display='yes', Category='grade')`
      );

      url.searchParams.append("sort[0][field]", "Label");
      //   url.searchParams.append("sort[0][direction]", "desc");

      //   alert(url);
      const response = await fetch(url, this.authorization);
      const data = await response.json();
      const records = data.records;
      const fields = records.map((record) => {
        return {
          label: record.fields.Label,
          field: record.fields.Field,
        };
      });
      return fields;
    },
    getScores() {
      if (this.fields === null) return;
      const id = this.key;
      this.isLoading = true;
      this.fullname = null;
      this.scores = [];
      let url = new URL(this.getUrl(this.airtable_grades_table));
      url.searchParams.set("fields", "ID");
      url.searchParams.append("fields", "FullName");
      url.searchParams.append("fields", "Section");
      this.fields.forEach((element) => {
        url.searchParams.append("fields", element.field);
      });
      url.searchParams.append("maxRecords", "30");
      url.searchParams.append("filterByFormula", `HID="${id}"`);
      // alert(`${url}${encodeURIComponent("filterByFormula=HID=")}`)
      //   const url2 = `https://api.airtable.com/v0/appLKzXucWNq7Ns0j/Grades?fields%5B%5D=ID&fields%5B%5D=QUIZ+1&fields%5B%5D=QUIZ+2&fields%5B%5D=QUIZ+3&fields%5B%5D=QUIZ+4&fields%5B%5D=QUIZ+5&fields%5B%5D=QUIZ+6&fields%5B%5D=BEST+4&fields%5B%5D=CLW+(NORMALIZED)&fields%5B%5D=Full+Name&filterByFormula=HID%3D%22${id}%22&maxRecords=20`;
      //   alert(encodeURI(url));
      fetch(url, this.authorization)
        .then((resp) => resp.json())
        .then((data) => {
          this.isLoading = false;
          const flds = data.records[0].fields;
          this.fullname = flds["FullName"];
          this.kfupm_id = flds["ID"];
          this.section = flds["Section"];

          this.scores = this.fields.map(({ label, field }) => {
            value = Array.isArray(flds[field]) ? flds[field][0] : flds[field];
            return {
              name: label,
              value: Math.round(100 * parseFloat(value)) / 100,
            };
          });
        });
    },
  };
}
