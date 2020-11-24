import Foundation
import SwiftUI

struct PageTwo: View {
    
    var body: some View {
        ScrollView {
            Image("csd-white-black") //change to font + logo + font image
                .resizable()
                .frame(width:150, height:57, alignment: .center)
                .padding(.bottom, 25)
            Text("""
                Hertz can be used to reduce anxiety, develop mental health resilience to stress, and with a sustained practise it can bring a greater level of conscious control to your anxiety levels. It should not be seen as a replacement for clinical treatment of mental health disorders, but as a safe and effective aid in nurturing mental health, and should be used as a component within a holistic strategy of caring for your mental health.
                """)
                .lineSpacing(5)
        }
    }
}
struct PageOne: View {
    var body: some View {
        ScrollView {
            Image("what")
                .resizable()
            .frame(width:400, height:34, alignment: .center)
            Image("Hertz")
                .resizable()
                .frame(width:100, height:100, alignment: .center)
            Text("""
            Hertz. provides biofeedback from your PNS to your brain. It has two components, a breathing component and a focus component.
            """)
                .font(Font.system(size: 14))
                .padding(15)
            Image("lungs")
                .resizable()
            .frame(width:90, height:90, alignment: .center)
            Text("""
                The breathing.
            """)
                .fontWeight(.black)
            Text("""
            The app coaches you to breath in a certain way which causes you to stimulate your vagus nerve just as you would with any meditative breathing exercise, or with relaxing activities such as yoga.
            """)
                .font(Font.system(size: 14))
            Image("brains")
                .resizable()
            .frame(width:90, height:90, alignment: .center)
            Text("""
                The Focus.
            """)
                .fontWeight(.black)
            Text("""
                The app has a red target which you should track with your eyes as it sweeps around the dial. The speed of this target changes as it moves, in sync with the breathing exercise. This level of change is controlled by your HRV.
                """)
                .font(Font.system(size: 14))
        }
    }
}
struct PageThree: View {
    var body: some View {
        ScrollView {
            Text("""
                A little background.
                """)
                .font(Font.system(size: 20))
                .fontWeight(.heavy)
                Text("""
                        ANS - Autonomic Nervous System.
                       """)
                    .font(Font.system(size: 20))
                    .fontWeight(.light)
                Text("""
                    The ANS is the part of your brain that runs all your background processes. Things like digestion, heart rate, salivating, breathing and the diameter of your pupils. You largely can’t consciously affect these processes, with breathing as an important exception.
                    One of the jobs the ANS has is to control your anxiety state. It has two forces controlling that state, one pushing the needle towards an anxious, ongoing crisis state (‘Fight or Flight’), and one pushing back, bring the needle towards a totally relaxed state (‘Rest and Digest’). These two forces are controlled by the sympathetic nervous system and the parasympathetic nervous system.
                    """)
                Text("""
                       SNS - Sympathetic Nervous System.
                       """)
                    .font(Font.system(size: 20))
                    .fontWeight(.light)
                Text("""
                    The SNS brings you towards the ‘Flight or Fight’ state. This prepares the body for action, the lungs open up, heart-rate increases, digestion is put on pause, the pupils dilate.
                    """)
                Text("""
                        PNS - Parasympathetic Nervous System.
                       """)
                    .font(Font.system(size: 20))
                    .fontWeight(.light)
                Text("""
                The PNS brings you towards the ‘Rest and Digest’ state. The body relaxes, the lungs close down a little and breathing slows. The heart relaxes and slows down, more blood is directed towards the digestive system, which gets more active.
                The PNS is largely controlled by the Vagus nerve.
                The Vagus nerve.
                The Vagus nerve is the main muscle behind the PNS force. When it’s activated it slows your heart rate, relaxes your muscles and calms you down. You can manually stimulate your Vagus by holding your breath for around 30 seconds, dipping your face in cold water, or coughing. Every time you stimulate the nerve, your heart pauses for a moment, which changes your heart rate variability.
                HRV - Heart Rate Variability.
                When your heart beats, it doesn’t do so with as regular a beat as a drum machine. The timing between every beat is a little different, this difference is your HRV value.
                Low HRV.
                • The difference in timing can be low, such as when your SNS has hit the ‘Fight or Flight’ alarm and your heart kicks into a high gear. Then the beats come regularly, like techno. Your heart is ready for an emergency in this state.
                High HRV.
                • The difference in timing can be high, when your PNS is more active, and your heart is recuperating. It slows down its beats, and they start to come at more irregular intervals, like jazz. Your heart is relaxing, and actually building resilience for future emergency states.
                """)
        }
    }
}
struct PageFour: View {
    var body: some View {
        ScrollView {
            Text("""
                 1. What Hertz. is and what it’s used for.Hertz. is an application that provides biofeedback from your PNS to your brain. It has two components, a breathing component and a focus component.The breathing.• The app coaches you to breath in a certain way which causes you to stimulate your vagus nerve just as you would with any meditativebreathing exercise, or with relaxing activities such as yoga.The focus.• The app has a red target which you should track with your eyes as it sweeps around the dial. The speed of this target changes as it moves, insync with the breathing exercise. This level of change is controlled by your HRV.As you use the app, it will stimulate the Vagus and reduce your anxiety directly. This will tone your Vagus and build resilience to future stress. Additionally, over time and with consistent practise, the biofeedback will set up an association with your conscious breath control, and the vagal nerve stimulation. This increases your direct control of your Vagus, building within yourself a powerful ability to consciously relax.2. What you should know before you use Hertz.- Although you will notice improvements in your anxiety levels directly from the first practise, these are only the effects of the breathing exercise.- Consistent practise over around one month is the minimum length of time needed to develop control of the Vagus.- The Apple Watch insists on showing the time on the upper right of the display, and older models shut off the screen after a short time. In theiPhone Watch app, go to: General > Wake Screen - under On Tap, select Wake for 70 Seconds. You can also rest a finger on the display to both hide the time and keep the screen on as you practise.3. How to use Hertz.Follow the bright red dot with your focused attention. As it passes the blue ticks, breath in, filling your belly, then your chest. As it passes the white tick, arrest your breathing without tensing. As it passes the brown ticks, slowly breath out through your nose, empty your lungs from the top down, drop your shoulders and relax.It’s best to practise directly after waking, before sleep and directly after exercise, in a calm, comfortable environment without distractions. Regular short sessions are preferred to sporadic longer sessions.4. Further information.Hertz is developed by Cybernetic Systems Development, a division of Mother. AB. For more information contact us at hertz@csd.red    As you use the app, it will stimulate the Vagus and reduce your anxiety directly. This will tone your Vagus and build resilience to future stress. Additionally, over time and with consistent practise, the biofeedback will set up an association with your conscious breath control, and the vagal nerve stimulation. This increases your direct control of your Vagus, building within yourself a powerful ability to consciously relax."
                """)
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
        VStack {
            Image("csd-white-black")
                .resizable()
                .frame(width:150, height:57, alignment: .center)
                .padding(.top, 50)
                .padding(.bottom, 25)
            ZStack {
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
            }
            .foregroundColor(.init(red: 0.888, green: 0.888, blue: 0.888))
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .background(Color.black)
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
