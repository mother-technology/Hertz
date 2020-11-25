import Foundation
import SwiftUI

struct PageOne: View {
    var body: some View {
        ScrollView {
            Group {
                Image("Hertz")
                    .resizable()
                    .frame(width:90, height:90, alignment: .center)
                    .padding(.top, 10)
                Image("what")
                    .resizable()
                    .frame(width:380, height:33, alignment: .center)
                Text("""
                Hertz. provides biofeedback from your vagus nerve to your brain. It has two components, a breathing component and a focus component.
                """)
                    .font(Font.system(size: 16))
                Image("lungs")
                    .resizable()
                    .frame(width:90, height:90, alignment: .center)
                    .padding(.top, 20)
                Text("""
                    The breathing.
                """)
                    .fontWeight(.black)
                    .font(Font.system(size: 20))
                    .padding(.top, 5)
                Text("""
                The app coaches you to breath in a certain way which causes you to stimulate your vagus nerve just as you would with any meditative breathing exercise, or with relaxing activities such as yoga.
                """)
                    .font(Font.system(size: 16))
                    .padding(.top, 1)
                Image("brains")
                    .resizable()
                    .frame(width:90, height:90, alignment: .center)
                    .padding(.top, 20)
                Text("""
                    The Focus.
                """)
                    .fontWeight(.black)
                    .font(Font.system(size: 20))
                    .padding(.top, 5)
                Text("""
                    The app has a red target which you should track with your eyes as it sweeps around the dial. The speed of this target changes as it moves, in sync with the breathing exercise. The level of change is controlled by your heart rate variability.
                    """)
                    .font(Font.system(size: 16))
                    .padding(.top, 1)
            }
        }
    } 
}
struct PageTwo: View {
    var body: some View {
        ScrollView {
            Group {
            Image("a-little-bg")
                .resizable()
                .frame(width:333, height:48, alignment: .center)
                .padding(.top, 28)
            Text("""
                    ANS - Autonomic Nervous System.
                   """)
                .font(Font.system(size: 20))
                .fontWeight(.heavy)
                .padding(.top, 24)
                Text("""
                    The ANS runs all your background processes, such as digestion, heart rate, salivating, breathing and the diameter of your pupils. You largely can’t consciously affect these processes, with breathing as an important exception. The ANS controls your anxiety state. It has two forces controlling that state, the SNS and PNS.
                    """)
                    .font(Font.system(size: 15))
                    .padding(.top, 12)
                Text("""
                       SNS - Sympathetic Nervous System.
                       """)
                    .font(Font.system(size: 20))
                    .fontWeight(.heavy)
                    .padding(.top, 24)
                Text("""
                    The SNS activates the ‘Flight or Fight’ state, preparing the body for action. The lungs open up, heart-rate increases, digestion is put on pause, the pupils dilate.
                    """)
                    .font(Font.system(size: 15))
                    .padding(.top, 12)
                Image("ans")
                    .resizable()
                    .frame(width:333, height:242, alignment: .center)
                Text("""
                        PNS - Parasympathetic Nervous System.
                       """)
                    .font(Font.system(size: 20))
                    .fontWeight(.heavy)
                    .padding(.top, 24)
                Text("""
                       The PNS brings you towards the ‘Rest and Digest’ state. The body relaxes, the lungs close down a little and breathing slows. The heart relaxes and slows down, more blood is directed towards the digestive system, which gets more active. The PNS is largely controlled by the Vagus nerve.
                       """)
                    .font(Font.system(size: 15))
                    .padding(.top, 12)
            }
        }
    }
}
struct PageThree: View {
    var body: some View {
        ScrollView {
            Group {
            Image("dont-panic")
                .resizable()
                .frame(width:294, height:33, alignment: .center)
                .padding(.top, 32)
            Image("vagus")
                .resizable()
                .frame(width:90, height:90, alignment: .center)
                .padding(.top, 2)
            Text("""
                   The Vagus nerve.
                   """)
                .font(Font.system(size: 20))
                .fontWeight(.heavy)
                .padding(.top, 1)
            Text("""
                   The main muscle behind the PNS force. When activated it slows your heart rate, relaxes your muscles and calms you down. You can stimulate your vagus by holding your breath for around 30 seconds, dipping your face in cold water, or coughing. Each time it's stimulated, your heart pauses, changing your heart rate variability.
                   """)
                .font(Font.system(size: 15))
                .padding(.top, 1)
            Text("""
               HRV - Heart Rate Variability.
               """)
                .fontWeight(.heavy)
                .padding(.top, 14)
            Text("""
                Your heart doesn’t beat as regularly as a drum machine. Every beat is a little different, this difference is your HRV.
                """)
                .font(Font.system(size: 15))
                .padding(.top, 1)
            Text("""
                Low HRV.
                """)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top,1)
                Text("""
                The differences can be low, when your SNS has hit the ‘Fight or Flight’ alarm and your heart kicks into high gear. Then the beats come regularly, like techno. Your heart is ready for an emergency.
                """)
                .font(Font.system(size: 15))
//                .padding(.top, 1)
            Text("""
                High HRV.
                """)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top,1)
                Text("""
                The differences can be high, when your PNS is dominant, and your heart is recuperating. It slows down its beats, and they come at irregular intervals, like jazz. Your heart is relaxing, and actually building resilience for future crises.
            """)
                .font(Font.system(size: 15))
//                .padding(.top, 1)
            }
        }
    }
}
struct PageFour: View {
    var body: some View {
        ScrollView {
            Group {
                Image("Hertz")
                    .resizable()
                    .frame(width:90, height:90, alignment: .center)
                    .padding(.top, 33)
            Text("""
                Hertz can be used to reduce anxiety, develop mental health resilience to stress, and with a sustained practise it can bring a greater level of conscious control to your anxiety levels. It should not be seen as a replacement for clinical treatment of mental health disorders, but as a safe and effective aid in nurturing mental health, and should be used as a component within a holistic strategy of caring for your mental health.
                """)
                .font(Font.system(size: 10))
                .padding(.top, 1)
            Text("""
                 1. What Hertz. is and what it’s used for.Hertz. is an application that provides biofeedback from your PNS to your brain. It has two components, a breathing component and a focus component.The breathing.• The app coaches you to breath in a certain way which causes you to stimulate your vagus nerve just as you would with any meditativebreathing exercise, or with relaxing activities such as yoga.The focus.• The app has a red target which you should track with your eyes as it sweeps around the dial. The speed of this target changes as it moves, insync with the breathing exercise. This level of change is controlled by your HRV.As you use the app, it will stimulate the Vagus and reduce your anxiety directly. This will tone your Vagus and build resilience to future stress. Additionally, over time and with consistent practise, the biofeedback will set up an association with your conscious breath control, and the vagal nerve stimulation. This increases your direct control of your Vagus, building within yourself a powerful ability to consciously relax.
                """)
                .font(Font.system(size: 9))
                .padding(.top, 1)
            Text("""
                2. What you should know before you use Hertz.- Although you will notice improvements in your anxiety levels directly from the first practise, these are only the effects of the breathing exercise.- Consistent practise over around one month is the minimum length of time needed to develop control of the Vagus.- The Apple Watch insists on showing the time on the upper right of the display, and older models shut off the screen after a short time. In theiPhone Watch app, go to: General > Wake Screen - under On Tap, select Wake for 70 Seconds. You can also rest a finger on the display to both hide the time and keep the screen on as you practise.
                """)
                .font(Font.system(size: 8))
                .padding(.top, 1)
            Text("""
                3. How to use Hertz.Follow the bright red dot with your focused attention. As it passes the blue ticks, breath in, filling your belly, then your chest. As it passes the white tick, arrest your breathing without tensing. As it passes the brown ticks, slowly breath out through your nose, empty your lungs from the top down, drop your shoulders and relax.It’s best to practise directly after waking, before sleep and directly after exercise, in a calm, comfortable environment without distractions. Regular short sessions are preferred to sporadic longer sessions.
                """)
                .font(Font.system(size: 7))
                .padding(.top, 1)
            Text("""
                4. Further information.Hertz is developed by Cybernetic Systems Development, a division of Mother. AB. For more information contact us at hertz@csd.red    As you use the app, it will stimulate the Vagus and reduce your anxiety directly. This will tone your Vagus and build resilience to future stress. Additionally, over time and with consistent practise, the biofeedback will set up an association with your conscious breath control, and the vagal nerve stimulation. This increases your direct control of your Vagus, building within yourself a powerful ability to consciously relax."
                """)
                .lineSpacing(1)
                .padding(.top, 1)
                .font(Font.system(size: 6))
                Image("csd-white-black")
                    .resizable()
                    .frame(width:122, height:50, alignment: .center)
                    .padding(.top, 22)
            }
        }
    }
}
struct CardGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding(30)
    }
}

struct Instructions: View {
    var body: some View {
        
//            Image("csd-white-black")
//                .resizable()
//                .frame(width:90, height:34, alignment: .center)
//                .padding(.top, 40)
            Group {
                TabView {
                    GroupBox {
                        PageOne()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .groupBoxStyle(CardGroupBoxStyle())
                    
                    GroupBox {
                        PageTwo()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .groupBoxStyle(CardGroupBoxStyle())
                    .shadow(radius: 10)
                    .padding(.all, 50)
                    GroupBox {
                        PageThree()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .groupBoxStyle(CardGroupBoxStyle())
                    .shadow(radius: 10)
                    .padding(.all, 50)
                    GroupBox {
                        PageFour()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .groupBoxStyle(CardGroupBoxStyle())
                    .shadow(radius: 10)
                    .padding(.all, 50)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .foregroundColor(.init(red: 0.888, green: 0.888, blue: 0.888))
            .background(Color.black)
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
