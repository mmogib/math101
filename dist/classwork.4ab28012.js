function showGrades() {
    return {
        isLoading: false,
        fullname: null,
        key: null,
        kfupm_id: null,
        scores: [],
        init () {
            const urlParams = new URLSearchParams(window.location.search);
            const myParam = urlParams.get("key");
            this.key = myParam;
            this.getScores();
        },
        getScores () {
            const id = this.key;
            this.isLoading = true;
            this.fullname = null;
            this.scores = [];
            let url = new URL("https://api.airtable.com/v0/appLKzXucWNq7Ns0j/Grades");
            url.searchParams.set("fields", "ID");
            url.searchParams.append("fields", "QUIZ 1");
            url.searchParams.append("fields", "FullName");
            url.searchParams.append("fields", "CLW (NORMALIZED)");
            url.searchParams.append("fields", "QUIZ 2");
            url.searchParams.append("fields", "QUIZ 3");
            url.searchParams.append("fields", "QUIZ 4");
            url.searchParams.append("fields", "QUIZ 5");
            url.searchParams.append("fields", "QUIZ 6");
            url.searchParams.append("fields", "BEST 4");
            url.searchParams.append("maxRecords", "30");
            url.searchParams.append("filterByFormula=HID", `"${id}"`);
            // alert(`${url}${encodeURIComponent("filterByFormula=HID=")}`)
            const url2 = `https://api.airtable.com/v0/appLKzXucWNq7Ns0j/Grades?fields%5B%5D=ID&fields%5B%5D=QUIZ+1&fields%5B%5D=QUIZ+2&fields%5B%5D=QUIZ+3&fields%5B%5D=QUIZ+4&fields%5B%5D=QUIZ+5&fields%5B%5D=QUIZ+6&fields%5B%5D=BEST+4&fields%5B%5D=CLW+(NORMALIZED)&fields%5B%5D=Full+Name&filterByFormula=HID%3D%22${id}%22&maxRecords=20`;
            alert(url);
            fetch(url, {
                headers: {
                    Authorization: "Bearer patS1tloTkU4PXgRN.5abcc400a57b06eb826e629ca497ec3055af4c437da7d6ff91902e060a4bb4f5"
                }
            }).then((resp)=>resp.json()).then((data)=>{
                this.isLoading = false;
                const flds = data.records[0].fields;
                const names = Object.keys(flds).sort().filter((n)=>n !== "FullName" && n !== "ID");
                this.fullname = flds["FullName"];
                this.kfupm_id = flds["ID"];
                this.scores = names.map((n)=>{
                    value = Array.isArray(flds[n]) ? flds[n][0] : flds[n];
                    return n !== "FullName" && {
                        name: n,
                        value
                    };
                });
            });
        }
    };
}

//# sourceMappingURL=classwork.4ab28012.js.map
