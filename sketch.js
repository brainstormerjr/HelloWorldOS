let chartRendered = false;



function learnMoreScroll() {
    document.getElementById("about1").scrollIntoView({behavior: 'smooth', block: 'start'});
}

function standardDownload() {
    document.getElementById("standardDownload").click();
}

function proDownload() {
    document.getElementById("proDownload").click();
}

function corporationDownload() {
    document.getElementById("corporationDownload").click();
}

const chartSettings = {
    type: 'bar',
    data: {
        labels: ['Windows 10', 'Windows 7', 'MacOS','Ubuntu', 'Chrome OS', 'Hello World OS'],
        datasets: [
            {
                data: [15.64 * 1024, 10.50 * 1024, 12.23 * 1024, 4.5 * 1024, 4 * 1024, 16/1024],
                //backgroundColor: ['rgb(255, 89, 139)', 'rgb(105, 197, 255)', 'rgb(175, 255, 105)', 'rgb(250, 126, 77)', 'rgb(142, 107, 255)'],
                backgroundColor: ["#db6eac", "#d160a8", "#d160c6", "#bc60d1", "#a868d4"],
                borderColor: ['#36447d'],
                borderWidth: 0,
                borderRadius: 6
            }
        ]
    },
    options: {
        plugins:{
            legend: {
                display: false
            }
        },
        scales: {
            y: {
                title: {
                    display: true,
                    text: 'Size On Disk (MB)',
                    color: 'rgb(0,0,0)',
                    font: {
                        size: 18,
                        family: 'Poppins',
                        style: 'sans-seriff',
                        weight: 600
                    }
                },
                ticks: {
                    color: 'rgb(0,0,0)',
                    font: {
                        size: 14,
                        family: 'Poppins',
                        weight: 600
                    }
                },
                grid: {
                    color: 'rgba(0, 0, 0, 0.1)',
                    borderColor: 'rgba(0, 0, 0, 1)',
                    borderWidth: 3,
                    drawTicks: false,
                    lineWidth: 3
                }
            },
            x: {
                ticks: {
                    color: 'rgb(0,0,0)',
                    font: {
                        size: 16,
                        family: 'Poppins',
                        weight: 600
                    }
                },
                grid: {
                    color: 'rgba(0, 0, 0, 0.1)',
                    borderColor: 'rgba(0, 0, 0, 1)',
                    borderWidth: 3,
                    drawTicks: false,
                    display: false
                }
            }
        },
        onAnimationComplete: function(){
            this.showTooltip(this.datasets[0].bars, true);
        },
        animation: {
            duration: 1000,
            easing: "easeOutQuart"
        },
        responsive: false,
        maintainAspectRatio: false,
    }
}

window.onload=function(){
    var canvas = document.getElementById("myChart");
    var parent = document.getElementById("parent");
    canvas.width = parent.offsetWidth - 2*80;
    console.log(Chart.defaults);
    if (isScrolledIntoView(document.getElementById("myChart"))) {
        var ctx = document.getElementById("myChart").getContext("2d");
        var myChart = new Chart(ctx, chartSettings);
        chartRendered = true;
    }
}

document.addEventListener('scroll', function(e) {
    if (chartRendered) return;

    if (isScrolledIntoView(document.getElementById("myChart"))) {
        var ctx = document.getElementById("myChart").getContext("2d");
        var myChart = new Chart(ctx, chartSettings);
        chartRendered = true;
    }
});

function isScrolledIntoView(el) {
    var rect = el.getBoundingClientRect();
    var elemTop = rect.top;
    var elemBottom = rect.bottom;

    // Only completely visible elements return true:
    // var isVisible = (elemTop >= 0) && (elemBottom <= window.innerHeight);
    // Partially visible elements return true:
    var isVisible = elemTop < window.innerHeight / 2;
    return isVisible;
}
