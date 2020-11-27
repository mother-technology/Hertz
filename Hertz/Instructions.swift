import Foundation
import SwiftUI
import AVKit

struct PageOne: View {
    var body: some View {
        ScrollView {
            VStack (alignment: .center) {
                Image("Hertz")
                    .resizable()
                    //.frame(width:90, height:90, alignment: .center)
                    .frame(width:180, height:180, alignment: .center)
                    .padding(.top, 24)
                Text("""
                        What it is and what it's used for.
                    """)
                    .fontWeight(.black)
                    .font(.system(size: 19))
                    .padding(.top, 20) //44
                Text("Hertz. provides biofeedback from your vagus nerve to your brain. It has two components, one for breathing and one for focus.")
                    .font(Font.system(size: 15))
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment:.leading)
                Image("lungs")
                    .resizable()
                    .frame(width:90, height:90, alignment: .center)
                    .padding(.top, 33)
                Text("""
                        The breathing.
                    """)
                    .fontWeight(.black)
                    .font(Font.system(size: 17))
                    .padding(.top, 5)
                Text("""
                    The app coaches you to breath in a certain way which causes you to stimulate your vagus nerve just as you would with any meditative breathing exercise, or with relaxing activities such as yoga.
                    """)
                    .font(Font.system(size: 15))
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment:.leading)
                Image("brains")
                    .resizable()
                    .frame(width:90, height:90, alignment: .center)
                    .padding(.top, 33)
                Text("""
                        The Focus.
                    """)
                    .fontWeight(.black)
                    .font(Font.system(size: 17))
                    .padding(.top, 5)
                Text("""
                        The app has a red target which you should track with your eyes as it sweeps around the dial. The speed of this target changes as it moves, in sync with the breathing exercise. The level of change is controlled by your heart rate variability.
                        """)
                    .font(Font.system(size: 15))
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment:.leading)
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .topLeading)
    } 
}
struct PageTwo: View {
    var body: some View {
        ScrollView {
            VStack (alignment: .center) {
                Text("""
                    A LITTLE BACKGROUND...
                """)
                    //.fontWeight(.black)
                    .font(.system(size: 12))
                    .padding(.top, 44)
                Text("""
                    Autonomic Nervous System.
                   """)
                    .font(Font.system(size: 19))
                    .fontWeight(.heavy)
                    .padding(.top, 11)
                Text("""
                    The ANS runs all your background processes, such as digestion, heart rate, salivating, breathing and the diameter of your pupils. You largely can’t consciously affect these processes, with breathing as an important exception. The ANS controls your anxiety state. It has two forces controlling that state, the SNS and PNS.
                    """)
                    .font(Font.system(size: 14))
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment:.leading)
                Text("""
                       Sympathetic Nervous System.
                       """)
                    .font(Font.system(size: 17))
                    .fontWeight(.heavy)
                    .padding(.top, 22)
                Text("""
                    The SNS activates the ‘Flight or Fight’ state, preparing the body for action. The lungs open up, heart-rate increases, digestion is put on pause, the pupils dilate.
                    """)
                    .font(Font.system(size: 14))
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment:.leading)
                Image("ans")
                    .resizable()
                    .frame(width:333, height:242, alignment: .center)
                    .padding(.top, 11)
                Text("""
                        Parasympathetic Nervous System.
                       """)
                    .font(Font.system(size: 17))
                    .fontWeight(.heavy)
                    .padding(.top, 22)
                Text("""
                       The PNS brings you towards the ‘Rest and Digest’ state. The body relaxes, breathing slows, the heart slows its beating, blood is directed towards the digestive system, which gets busy.
                       """)
                    .font(Font.system(size: 14))
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment:.leading)
                Text("""
                       The PNS is largely controlled by the vagus nerve.
                       """)
                    .font(Font.system(size: 14))
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment:.leading)
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .topLeading)
    }
}
struct PageThree: View {
    var body: some View {
        ScrollView {
            VStack (alignment: .center) {
                Group {
                    Text("""
                    A LITTLE MORE BACKGROUND...
                """)
                        .font(.system(size: 12))
                        .padding(.top, 44)
                    Image("vagus")
                        .resizable()
                        .frame(width:90, height:90, alignment: .center)
                        .padding(.top, 33)
                    Text("""
                   The Vagus nerve.
                   """)
                        .font(Font.system(size: 19))
                        .fontWeight(.heavy)
                        .padding(.top, 5)
                    Text("""
                   The main power behind the relaxing PNS force, itx relaxes your muscles, slows your heart and calms you down. Stimulate your vagus by holding your breath for around 30 seconds, dipping your face in cold water or coughing. Each time it's stimulated, your heart pauses, changing your heart rate variability.
                   """)
                        .font(Font.system(size: 14))
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity, alignment:.leading)
                    Text("""
               HRV - Heart Rate Variability.
               """)
                        .fontWeight(.heavy)
                        .padding(.top, 44)
                    Text("""
                Your heart doesn’t beat as regularly as a drum machine. Every beat is a little different, this difference is your HRV.
                """)
                        .font(Font.system(size: 14))
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity, alignment:.leading)
                    Text("""
                LOW HRV.
                """)
                        //.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(Font.system(size: 12))
                        .frame(maxWidth: .infinity, alignment:.center)
                        .padding(.top, 5)
                }
                Group {
                    Image("low-hrv")
                        .resizable()
                        .frame(width:333, height:48, alignment: .center)
                        .padding(.top, 5)
                    Text("""
                The differences can be low, when your SNS has hit the ‘Fight or Flight’ alarm and your heart kicks into high gear. Then the beats come regularly, like techno. Your heart is ready for an emergency.
                """)
                        .font(Font.system(size: 14))
                        .padding(.top, 1)
                        .frame(maxWidth: .infinity, alignment:.leading)
                    Text("""
                HIGH HRV.
                """)
                        //.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(Font.system(size: 12))
                        .frame(maxWidth: .infinity, alignment:.center)
                        .padding(.top, 5)
                    Image("high-hrv")
                        .resizable()
                        .frame(width:333, height:48, alignment: .center)
                        .padding(.top, 5)
                    Text("""
                The differences can be high, when your PNS is dominant, and your heart is recuperating. It slows down its beats, and they come at irregular intervals, like jazz. Your heart is relaxing, and actually building resilience for future crises.
                """)
                        .font(Font.system(size: 15))
                        .frame(maxWidth: .infinity, alignment:.leading)
                }
            }
        }
    }
}

struct PageFour: View {
    var body: some View {
        ScrollView {
            VStack (alignment: .center) {
                Group {
                    Text("""
                THE END OF THE BACKGROUND.
                """)
                        .font(.system(size: 12))
                        .padding(.top, 44)
                    Image("cvc")
                        .resizable()
                        .frame(width:90, height:90, alignment: .center)
                        .padding(.top, 24)
                    Text("""
                   CVC - Cardiac Vagal Control.
                   """)
                        .font(Font.system(size: 19))
                        .fontWeight(.heavy)
                        .padding(.top, 5)
                    Text("""
                   CVC indicates how well controlled your heart is by your vagus. A high value indicates a responsive, sensitive and rapidly changing system and correlates with good health, positive emotions, effective executive function and overall better self-regulation. Think of it as a measure of how much emotional unflappability you have in reserve.
                   """)
                        .font(Font.system(size: 14))
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity, alignment:.leading)
                    Image("Hertz")
                        .resizable()
                        .frame(width:90, height:90, alignment: .center)
                        .padding(.top, 20)
                    Text("""
                Hertz. stimulates your vagus, reducing anxiety directly. This will tone your vagus, building resilience to future stress. Over time the biofeedback will set up a connection between your conscious breath control and the vagal nerve stimulation, increasing your CVC and developing within yourself a powerful ability to consciously relax.
                """)
                        .font(Font.system(size: 14))
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity, alignment:.leading)
                    Image("month")
                        .resizable()
                        .frame(width:80, height:63, alignment: .center)
                        .padding(.top, 20)
                    Text("""
                Consistent daily practise over around one month is the minimum length of time needed to develop control of the vagus.
                """)
                        .font(Font.system(size: 14))
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity, alignment:.leading)
                    Text("""
                    The Apple Watch insists on showing the time on the upper right of the display, and older models shut off the screen after a short time. In the iPhone Watch app, go to: General > Wake Screen - under On Tap, select Wake for 70 Seconds. You can also rest a finger on the display to both hide the time and keep the screen on as you practise.
                    """)
                        .font(Font.system(size: 15))
                        .padding(.top, 1)
                }
            }
        }
    }
}
struct PageFive: View {
    var body: some View {
        ScrollView {
            VStack (alignment: .center){
                Group {
                    Image("morning")
                        .resizable()
                        .frame(width:355, height:70, alignment: .center)
                        .padding(.top, 44)
                    Text("""
                    Tips and tricks.
                """)
                        .fontWeight(.black)
                        .font(.system(size: 23))
                        .padding(.top, 22)
                }
                Group {
                    Text("""
                Best to practise directly after waking, straight after exercise, and just before sleep.
                """)
                        .font(Font.system(size: 14))
                        .padding(.top, 10)
                    Text("""
                Regular short sessions beat sporadic long ones.
                """)
                        .font(Font.system(size:14))
                        .padding(.top, 10)
                    Text("""
                Practise in a calm, comfortable environment without distractions.
                """)
                        .font(Font.system(size: 14))
                        .padding(.top, 10)
                    Text("""
                The more you practise, the more rapid progress will be.
                """)
                        .font(Font.system(size: 14))
                        .padding(.top, 10)
                    Text("""
                Try to 'will' the dot to slow down as you breath out.
                """)
                        .font(Font.system(size: 14))
                        .padding(.top, 10)
                    Text("""
                As you recognise the sensation of activating your vagus, practise its activation also without the app.
                """)
                        .font(Font.system(size: 14))
                        .padding(.top, 10)
                    Text("""
                Good luck!
                """)
                        .font(Font.system(size: 16))
                        .fontWeight(.bold)
                        .padding(.top, 44)
                    Link(destination: URL(string: "https://cyberneticsystemsdevelopment.com")!, label: {
                        Image("csd-white-black")
                        .resizable()
                        .frame(width:343, height:77, alignment: .center)
                    })
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
        }
    }
}
struct PageSix: View {
    var body: some View {
            VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "preview", withExtension: "mp4")!))
    }
}

struct Instructions: View {
    @State private var currentPage = 0
    var body: some View {
        //        VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "Resources/App Preview", withExtension: "mp4")!))
        VStack {
            PagerView(pageCount: 6, currentIndex: $currentPage) {
                PageOne()
                    .padding(20)
                PageTwo()
                    .padding(20)
                PageThree()
                    .padding(20)
                PageFour()
                    .padding(20)
                PageFive()
                    .padding(20)
                PageSix()
                    .padding(20)
            }
        }
        .foregroundColor(.init(red: 0.888, green: 0.888, blue: 0.888))
        .background(Color.black.edgesIgnoringSafeArea(.bottom))
        .background(Color.black)
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
