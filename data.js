function showGrades() {
    return {
        isLoading: false,
        fullname: null,
        key: null,
        kfupm_id:null,
        scores: [],
        init(){
            const urlParams = new URLSearchParams(window.location.search);
            const myParam = urlParams.get('key');
            this.key= myParam
            this.getScores()
        },
        getScores() {
                this.isLoading = true
                this.scores = []
                this.fullname = null
                const id = this.key
                fetch(`https://api.airtable.com/v0/appLKzXucWNq7Ns0j/Grades?fields%5B%5D=ID&fields%5B%5D=QUIZ+1&fields%5B%5D=QUIZ+2&fields%5B%5D=QUIZ+3&fields%5B%5D=QUIZ+4&fields%5B%5D=QUIZ+5&fields%5B%5D=QUIZ+6&fields%5B%5D=BEST+4&fields%5B%5D=CLW+(NORMALIZED)&fields%5B%5D=Full+Name&filterByFormula=HID%3D%22${id}%22&maxRecords=20`, {
                    headers: {
                        Authorization: "Bearer patS1tloTkU4PXgRN.5abcc400a57b06eb826e629ca497ec3055af4c437da7d6ff91902e060a4bb4f5",
                    }
                }).then(
                    resp => resp.json()
                ).then(data => {
                    this.isLoading = false
                    const flds = data.records[0].fields
                    const names = Object.keys(flds).sort().filter(n=>n!=='Full Name' && n!=="ID")
                    this.fullname = flds['Full Name']
                    this.kfupm_id = flds['ID']
                    
                    this.scores = names.map(n => {
                        value = Array.isArray(flds[n]) ? flds[n][0] : flds[n];
                        return n !== 'Full Name' && { name: n, value }

                    })
                })
            }

        }
    
}
