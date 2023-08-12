function showGrades() {
    return {
        isLoading: false,
        fullname: null,
        scores: [],
        getScores(id) {
            if (String(id).length === 9) {

                this.isLoading = true
                this.scores = []
                this.fullname = null
                fetch(`https://api.airtable.com/v0/appLKzXucWNq7Ns0j/Grades?fields%5B%5D=QUIZ+1&fields%5B%5D=QUIZ+2&fields%5B%5D=QUIZ+3&fields%5B%5D=QUIZ+4&fields%5B%5D=QUIZ+5&fields%5B%5D=QUIZ+6&fields%5B%5D=BEST+4&fields%5B%5D=CLW+(NORMALIZED)&fields%5B%5D=Full+Name&filterByFormula=ID%3D${id}&maxRecords=20`, {
                    headers: {
                        Authorization: "Bearer key5fxKsZ0cka9x9D",
                    }
                }).then(
                    resp => resp.json()
                ).then(data => {
                    this.isLoading = false
                    const flds = data.records[0].fields
                    const names = Object.keys(flds).sort().filter(n=>n!=='Full Name')
                    this.fullname = flds['Full Name']
                    this.scores = names.map(n => {
                        value = Array.isArray(flds[n]) ? flds[n][0] : flds[n];
                        return n !== 'Full Name' && { name: n, value }

                    })
                })
            }

        }
    }
}
